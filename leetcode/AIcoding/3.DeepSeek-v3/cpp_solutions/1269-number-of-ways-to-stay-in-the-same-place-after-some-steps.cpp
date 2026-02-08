class Solution {
public:
    int numWays(int steps, int arrLen) {
        const int MOD = 1e9 + 7;
        int maxPos = min(steps / 2 + 1, arrLen);
        vector<vector<int>> dp(steps + 1, vector<int>(maxPos + 2, 0));
        dp[0][0] = 1;

        for (int i = 1; i <= steps; ++i) {
            for (int j = 0; j < maxPos; ++j) {
                dp[i][j] = dp[i - 1][j];
                if (j > 0) {
                    dp[i][j] = (dp[i][j] + dp[i - 1][j - 1]) % MOD;
                }
                if (j < maxPos - 1) {
                    dp[i][j] = (dp[i][j] + dp[i - 1][j + 1]) % MOD;
                }
            }
        }

        return dp[steps][0];
    }
};