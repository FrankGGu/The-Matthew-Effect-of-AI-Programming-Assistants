class Solution {
public:
    int countCombinations(int n, int k) {
        vector<vector<int>> dp(n + 1, vector<int>(n + 1, 0));
        dp[0][0] = 1;

        for (int i = 1; i <= n; ++i) {
            for (int j = 0; j <= k; ++j) {
                dp[i][j] = dp[i - 1][j];
                if (j > 0) {
                    dp[i][j] += dp[i - 1][j - 1] * (i - 1);
                }
            }
        }

        return dp[n][k];
    }
};