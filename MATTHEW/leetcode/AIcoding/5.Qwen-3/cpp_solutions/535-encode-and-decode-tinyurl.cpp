#include <iostream>
#include <string>
#include <vector>
#include <unordered_map>

using namespace std;

class Solution {
private:
    unordered_map<string, string> urlMap;
    const string chars = "0123456789abcdefghijklmnopqrstuvwxyzABCDEFGHIJKLMNOPQRSTUVWXYZ";
    int counter = 0;

    string encode(int id) {
        string shortUrl = "";
        while (id > 0) {
            shortUrl = chars[id % 62] + shortUrl;
            id /= 62;
        }
        return shortUrl;
    }

public:
    string encode(string longUrl) {
        if (urlMap.find(longUrl) != urlMap.end()) {
            return urlMap[longUrl];
        }
        string shortUrl = encode(counter++);
        urlMap[longUrl] = shortUrl;
        return shortUrl;
    }

    string decode(string shortUrl) {
        return urlMap[shortUrl];
    }
};