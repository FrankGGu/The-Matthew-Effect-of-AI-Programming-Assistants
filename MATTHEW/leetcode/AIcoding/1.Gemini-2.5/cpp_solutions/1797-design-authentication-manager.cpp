#include <string>
#include <unordered_map>

class AuthenticationManager {
private:
    int timeToLive_;
    std::unordered_map<std::string, int> tokens_; // tokenId -> expirationTime

public:
    AuthenticationManager(int timeToLive) {
        timeToLive_ = timeToLive;
    }

    void generate(std::string tokenId, int currentTime) {
        tokens_[tokenId] = currentTime + timeToLive_;
    }

    void renew(std::string tokenId, int currentTime) {
        if (tokens_.count(tokenId)) {
            if (tokens_[tokenId] > currentTime) {
                tokens_[tokenId] = currentTime + timeToLive_;
            }
        }
    }

    int countUnexpiredTokens(int currentTime) {
        int count = 0;
        for (const auto& pair : tokens_) {
            if (pair.second > currentTime) {
                count++;
            }
        }
        return count;
    }
};