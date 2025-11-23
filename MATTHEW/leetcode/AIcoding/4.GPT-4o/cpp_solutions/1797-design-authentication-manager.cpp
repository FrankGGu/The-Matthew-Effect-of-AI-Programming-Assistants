class AuthenticationManager {
public:
    AuthenticationManager(int timeToLive) {
        this->ttl = timeToLive;
    }

    void generate(string tokenId, int currentTime) {
        tokenMap[tokenId] = currentTime + ttl;
    }

    void renew(string tokenId, int currentTime) {
        if (tokenMap.count(tokenId) && tokenMap[tokenId] > currentTime) {
            tokenMap[tokenId] = currentTime + ttl;
        }
    }

    int countUnexpiredTokens(int currentTime) {
        int count = 0;
        for (auto& [tokenId, expiryTime] : tokenMap) {
            if (expiryTime > currentTime) {
                count++;
            }
        }
        return count;
    }

private:
    unordered_map<string, int> tokenMap;
    int ttl;
};