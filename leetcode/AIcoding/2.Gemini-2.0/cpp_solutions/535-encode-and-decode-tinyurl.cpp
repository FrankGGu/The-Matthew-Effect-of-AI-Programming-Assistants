#include <string>
#include <unordered_map>
#include <random>

class Solution {
public:
    Solution() : rand_gen(std::random_device{}()) {}

    std::string encode(std::string longUrl) {
        std::string tinyUrl = "http://tinyurl.com/" + generateRandomString(6);
        longToShort[longUrl] = tinyUrl;
        shortToLong[tinyUrl] = longUrl;
        return tinyUrl;
    }

    std::string decode(std::string shortUrl) {
        return shortToLong[shortUrl];
    }

private:
    std::unordered_map<std::string, std::string> longToShort;
    std::unordered_map<std::string, std::string> shortToLong;
    std::mt19937 rand_gen;

    std::string generateRandomString(int length) {
        const std::string charSet = "abcdefghijklmnopqrstuvwxyzABCDEFGHIJKLMNOPQRSTUVWXYZ0123456789";
        std::uniform_int_distribution<> distrib(0, charSet.length() - 1);
        std::string randomString;
        for (int i = 0; i < length; ++i) {
            randomString += charSet[distrib(rand_gen)];
        }
        return randomString;
    }
};