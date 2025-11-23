#include <iostream>
#include <vector>
#include <unordered_map>
#include <algorithm>

using namespace std;

class Solution {
private:
    unordered_map<string, int> authMap;
    int time;

public:
    Solution(int timeToLive) {
        time = timeToLive;
    }

    void generate(string tokenId, int currentTime, int expirationTime) {
        authMap[tokenId] = currentTime + expirationTime;
    }

    void renew(string tokenId, int currentTime) {
        if (authMap.find(tokenId) != authMap.end() && authMap[tokenId] > currentTime) {
            authMap[tokenId] = currentTime + time;
        }
    }

    void drop(string tokenId, int currentTime) {
        if (authMap.find(tokenId) != authMap.end() && authMap[tokenId] > currentTime) {
            authMap.erase(tokenId);
        }
    }

    int countUnexpiredTokens(int currentTime) {
        int count = 0;
        for (auto& [id, expireTime] : authMap) {
            if (expireTime > currentTime) {
                count++;
            }
        }
        return count;
    }
};