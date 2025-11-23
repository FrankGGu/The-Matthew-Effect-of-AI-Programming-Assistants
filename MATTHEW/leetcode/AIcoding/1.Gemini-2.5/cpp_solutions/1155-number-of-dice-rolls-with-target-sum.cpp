#include <vector>

class Solution {
public:
    int numRollsToTarget(int n, int f, int target) {
        int MOD = 1e9 + 7;
        std::vector<std::vector<int>> dp(n + 1, std::vector<int>(target + 1, 0));

        dp[0][0] = 1;

        for (int i = 1; i <= n; ++i) {
            for (int j = 1; j <= target; ++j) {
                for (int k = 1; k <= f; ++k) {
                    if (j - k >= 0) {
                        dp[i][j] = (dp[i][j] + dp[i - 1][j - k]) % MOD;
                    }
                }
            }
        }

        return dp[n][target];
    }
};