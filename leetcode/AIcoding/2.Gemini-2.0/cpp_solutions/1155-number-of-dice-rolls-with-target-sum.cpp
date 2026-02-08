#include <vector>

using namespace std;

class Solution {
public:
    int numRollsToTarget(int n, int k, int target) {
        int mod = 1e9 + 7;
        vector<vector<int>> dp(n + 1, vector<int>(target + 1, 0));
        dp[0][0] = 1;

        for (int i = 1; i <= n; ++i) {
            for (int j = 1; j <= target; ++j) {
                for (int x = 1; x <= k; ++x) {
                    if (j - x >= 0) {
                        dp[i][j] = (dp[i][j] + dp[i - 1][j - x]) % mod;
                    }
                }
            }
        }

        return dp[n][target];
    }
};