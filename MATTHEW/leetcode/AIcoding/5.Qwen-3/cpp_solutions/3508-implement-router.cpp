#include <iostream>
#include <vector>
#include <string>
#include <unordered_map>

using namespace std;

class Solution {
public:
    vector<int> split(const string& s, char delimiter) {
        vector<int> tokens;
        string token;
        for (char c : s) {
            if (c == delimiter) {
                tokens.push_back(stoi(token));
                token.clear();
            } else {
                token += c;
            }
        }
        if (!token.empty()) {
            tokens.push_back(stoi(token));
        }
        return tokens;
    }

    bool match(const vector<int>& path1, const vector<int>& path2) {
        if (path1.size() != path2.size()) return false;
        for (size_t i = 0; i < path1.size(); ++i) {
            if (path1[i] != -1 && path2[i] != -1 && path1[i] != path2[i]) {
                return false;
            }
        }
        return true;
    }

    int get(const vector<int>& path) {
        vector<vector<int>> routes = {
            {1, 2, 3},
            {1, 2, 4},
            {1, 3, 5},
            {2, 3, 6}
        };
        for (const auto& route : routes) {
            if (match(path, route)) {
                return 200;
            }
        }
        return 404;
    }

    int post(const vector<int>& path, const string& body) {
        vector<vector<int>> routes = {
            {1, 2, 3},
            {1, 2, 4},
            {1, 3, 5},
            {2, 3, 6}
        };
        for (const auto& route : routes) {
            if (match(path, route)) {
                return 201;
            }
        }
        return 404;
    }

    int put(const vector<int>& path, const string& body) {
        vector<vector<int>> routes = {
            {1, 2, 3},
            {1, 2, 4},
            {1, 3, 5},
            {2, 3, 6}
        };
        for (const auto& route : routes) {
            if (match(path, route)) {
                return 200;
            }
        }
        return 404;
    }

    int del(const vector<int>& path) {
        vector<vector<int>> routes = {
            {1, 2, 3},
            {1, 2, 4},
            {1, 3, 5},
            {2, 3, 6}
        };
        for (const auto& route : routes) {
            if (match(path, route)) {
                return 200;
            }
        }
        return 404;
    }

    int router(const string& method, const string& path, const string& body) {
        vector<int> pathInt = split(path, '/');
        if (method == "GET") {
            return get(pathInt);
        } else if (method == "POST") {
            return post(pathInt, body);
        } else if (method == "PUT") {
            return put(pathInt, body);
        } else if (method == "DELETE") {
            return del(pathInt);
        }
        return 405;
    }
};