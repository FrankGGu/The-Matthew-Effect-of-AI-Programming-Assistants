class AuthenticationManager {
private:
    int timeToLive;
    unordered_map<string, int> tokenExpiry;

public:
    AuthenticationManager(int timeToLive) : timeToLive(timeToLive) {}

    void generate(string tokenId, int currentTime) {
        tokenExpiry[tokenId] = currentTime + timeToLive;
    }

    void renew(string tokenId, int currentTime) {
        if (tokenExpiry.find(tokenId) != tokenExpiry.end() && tokenExpiry[tokenId] > currentTime) {
            tokenExpiry[tokenId] = currentTime + timeToLive;
        }
    }

    int countUnexpiredTokens(int currentTime) {
        int count = 0;
        for (const auto& pair : tokenExpiry) {
            if (pair.second > currentTime) {
                count++;
            }
        }
        return count;
    }
};