#include <iostream>
#include <vector>
#include <string>
#include <unordered_map>
#include <algorithm>

class Solution {
public:
    int longestCommonSubpath(int n, std::vector<std::vector<int>>& paths) {
        std::vector<std::vector<int>> allPaths = paths;
        int minLen = INT_MAX;
        for (const auto& path : allPaths) {
            minLen = std::min(minLen, static_cast<int>(path.size()));
        }

        int low = 0, high = minLen;
        int result = 0;

        while (low <= high) {
            int mid = (low + high) / 2;
            if (hasCommonSubpath(allPaths, mid)) {
                result = mid;
                low = mid + 1;
            } else {
                high = mid - 1;
            }
        }

        return result;
    }

private:
    bool hasCommonSubpath(const std::vector<std::vector<int>>& paths, int k) {
        if (k == 0) return true;

        std::unordered_map<size_t, int> hashCount;
        size_t base = 10000007;
        size_t mod = 1000000007;

        for (const auto& path : paths) {
            std::unordered_map<size_t, int> currentHashes;
            size_t hash = 0;
            for (int i = 0; i < k; ++i) {
                hash = (hash * base + path[i]) % mod;
            }
            currentHashes[hash] = 1;

            for (int i = k; i < static_cast<int>(path.size()); ++i) {
                hash = (hash * base + path[i] - static_cast<size_t>(path[i - k]) * base) % mod;
                if (hash < 0) hash += mod;
                currentHashes[hash] = 1;
            }

            for (const auto& [h, _] : currentHashes) {
                hashCount[h]++;
            }
        }

        for (const auto& [h, count] : hashCount) {
            if (count == static_cast<int>(paths.size())) {
                return true;
            }
        }

        return false;
    }
};