class Solution {
public:
    int shortestSupersequence(string s, string t) {
        int n = s.size(), m = t.size();
        vector<vector<int>> dp(n + 1, vector<int>(m + 1, INT_MAX));
        for (int i = 0; i <= n; ++i) dp[i][0] = 0;
        for (int j = 1; j <= m; ++j) dp[0][j] = INT_MAX;

        for (int i = 1; i <= n; ++i) {
            for (int j = 1; j <= m; ++j) {
                if (s[i - 1] == t[j - 1]) {
                    dp[i][j] = min(dp[i - 1][j - 1] + 1, dp[i - 1][j] + 1);
                } else {
                    dp[i][j] = min(dp[i - 1][j] + 1, dp[i][j - 1]);
                }
            }
        }

        return dp[n][m];
    }
};