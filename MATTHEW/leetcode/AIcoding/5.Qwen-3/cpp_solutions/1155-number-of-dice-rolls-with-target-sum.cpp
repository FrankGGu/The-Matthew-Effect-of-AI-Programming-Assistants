#include <vector>
#include <cmath>

class Solution {
public:
    int numRollsToTarget(int n, int k, int target) {
        const int MOD = 1e9 + 7;
        std::vector<std::vector<int>> dp(n + 1, std::vector<int>(target + 1, 0));
        dp[0][0] = 1;

        for (int i = 1; i <= n; ++i) {
            for (int j = 1; j <= target; ++j) {
                for (int face = 1; face <= k && j - face >= 0; ++face) {
                    dp[i][j] = (dp[i][j] + dp[i - 1][j - face]) % MOD;
                }
            }
        }

        return dp[n][target];
    }
};