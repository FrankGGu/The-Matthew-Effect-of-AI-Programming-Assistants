class Solution {
public:
    int minimumPushes(string word1, string word2) {
        int m = word1.size(), n = word2.size();
        vector<vector<int>> dp(m + 1, vector<int>(n + 1, INT_MAX));
        dp[0][0] = 0;

        for (int i = 0; i <= m; ++i) {
            for (int j = 0; j <= n; ++j) {
                if (i < m && j < n && word1[i] == word2[j]) {
                    dp[i + 1][j + 1] = min(dp[i + 1][j + 1], dp[i][j]);
                }
                if (i < m) {
                    dp[i + 1][j] = min(dp[i + 1][j], dp[i][j] + 1);
                }
                if (j < n) {
                    dp[i][j + 1] = min(dp[i][j + 1], dp[i][j] + 1);
                }
            }
        }

        return dp[m][n];
    }
};