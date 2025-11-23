#include <unordered_map>

class AuthenticationManager {
public:
    AuthenticationManager(int timeToLive) : timeToLive_(timeToLive) {}

    void generate(string tokenId, int currentTime) {
        tokens_[tokenId] = currentTime + timeToLive_;
    }

    void renew(string tokenId, int currentTime) {
        if (tokens_.count(tokenId) && tokens_[tokenId] > currentTime) {
            tokens_[tokenId] = currentTime + timeToLive_;
        }
    }

    int countUnexpiredTokens(int currentTime) {
        int count = 0;
        for (auto const& [key, val] : tokens_) {
            if (val > currentTime) {
                count++;
            }
        }
        return count;
    }

private:
    int timeToLive_;
    unordered_map<string, int> tokens_;
};