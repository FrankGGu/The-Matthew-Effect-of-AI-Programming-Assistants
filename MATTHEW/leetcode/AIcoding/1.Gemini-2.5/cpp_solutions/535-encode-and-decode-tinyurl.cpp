#include <iostream>
#include <string>
#include <unordered_map>
#include <random>

class Solution {
public:

    std::string alphabet = "abcdefghijklmnopqrstuvwxyzABCDEFGHIJKLMNOPQRSTUVWXYZ0123456789";
    std::unordered_map<std::string, std::string> longToShort;
    std::unordered_map<std::string, std::string> shortToLong;
    std::string baseURL = "http://tinyurl.com/";

    std::string generateShortURL() {
        std::string shortURL = "";
        std::random_device rd;
        std::mt19937 gen(rd());
        std::uniform_int_distribution<> distrib(0, alphabet.size() - 1);
        for (int i = 0; i < 6; ++i) {
            shortURL += alphabet[distrib(gen)];
        }
        return shortURL;
    }

    std::string encode(std::string longURL) {
        if (longToShort.count(longURL)) {
            return baseURL + longToShort[longURL];
        }
        std::string shortURL = generateShortURL();
        while (shortToLong.count(shortURL)) {
            shortURL = generateShortURL();
        }
        longToShort[longURL] = shortURL;
        shortToLong[shortURL] = longURL;
        return baseURL + shortURL;
    }

    std::string decode(std::string shortURL) {
        std::string tiny = shortURL.substr(baseURL.size());
        return shortToLong[tiny];
    }
};