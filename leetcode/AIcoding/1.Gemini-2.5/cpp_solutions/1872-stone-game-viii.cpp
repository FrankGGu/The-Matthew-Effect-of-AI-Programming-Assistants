#include <vector>
#include <numeric>
#include <algorithm>

class Solution {
public:
    int stoneGameVIII(std::vector<int>& stones) {
        int n = stones.size();
        std::vector<long long> prefix(n);
        prefix[0] = stones[0];
        for (int i = 1; i < n; ++i) {
            prefix[i] = prefix[i - 1] + stones[i];
        }

        long long dp = prefix[n - 1];
        for (int i = n - 2; i >= 1; --i) {
            dp = std::max(dp, prefix[i] - dp);
        }

        return static_cast<int>(dp);
    }
};