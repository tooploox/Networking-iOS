//
// Created by Karol Wieczorek on 11.12.2017.
// Copyright (c) 2017 Tooploox. All rights reserved.
//

import Foundation

public protocol URLRequestBuilder {
    func build(from request: ApiRequest) -> URLRequest?
}

public class StandardURLRequestBuilder: URLRequestBuilder {

    private let host: String

    public init(host: String) {
        self.host = host
    }

    public func build(from request: ApiRequest) -> URLRequest? {
        guard let  url = URL(string: host + request.endpoint) else { return nil }
        var urlRequest = URLRequest(url: url)
        urlRequest.httpMethod = request.method.toString()
        if let parameters = request.parameters, let body = (try? JSONSerialization.data(withJSONObject: parameters)) {
            urlRequest.httpBody = body
        }
        if let headers = request.headers {
            for (key, value) in headers {
                urlRequest.setValue(value, forHTTPHeaderField: key)
            }
        }

        return urlRequest
    }
}
