#include <vector>
#include <algorithm>

class Solution {
public:
    int dieSimulator(int n, int k) {
        const int MOD = 1000000007;
        std::vector<int> dp(6, 1);
        for (int i = 1; i < n; ++i) {
            std::vector<int> next_dp(6, 0);
            for (int j = 0; j < 6; ++j) {
                for (int m = 0; m < 6; ++m) {
                    if (j != m) {
                        next_dp[j] = (next_dp[j] + dp[m]) % MOD;
                    }
                }
            }
            dp = next_dp;
        }
        return std::accumulate(dp.begin(), dp.end(), 0) % MOD;
    }
};