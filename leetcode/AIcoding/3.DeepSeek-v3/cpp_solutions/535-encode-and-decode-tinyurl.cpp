class Solution {
private:
    unordered_map<string, string> urlMap;
    int count = 0;
    const string base = "http://tinyurl.com/";

public:
    string encode(string longUrl) {
        string shortUrl = base + to_string(count++);
        urlMap[shortUrl] = longUrl;
        return shortUrl;
    }

    string decode(string shortUrl) {
        return urlMap[shortUrl];
    }
};