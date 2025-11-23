class Solution {
public:
    int minimumScore(string s, string t) {
        int n = s.size(), m = t.size();
        vector<vector<int>> dp(n + 1, vector<int>(m + 1, INT_MAX));
        dp[0][0] = 0;

        for (int i = 0; i <= n; ++i) {
            for (int j = 0; j <= m; ++j) {
                if (i < n) dp[i + 1][j] = min(dp[i + 1][j], dp[i][j] + 1);
                if (j < m) dp[i][j + 1] = min(dp[i][j + 1], dp[i][j] + 1);
                if (i < n && j < m && s[i] == t[j]) {
                    dp[i + 1][j + 1] = min(dp[i + 1][j + 1], dp[i][j]);
                }
            }
        }

        return dp[n][m] == INT_MAX ? -1 : dp[n][m];
    }
};