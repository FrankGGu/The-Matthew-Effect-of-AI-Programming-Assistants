class Solution {
public:
    int tilingRectangle(int n, int m) {
        if (n > m) swap(n, m);
        vector<vector<int>> dp(n + 1, vector<int>(m + 1, INT_MAX));
        dp[0][0] = 0;

        for (int i = 1; i <= n; ++i) {
            for (int j = 1; j <= m; ++j) {
                for (int size = 1; size <= min(i, j); ++size) {
                    dp[i][j] = min(dp[i][j], dp[i - size][j] + dp[size][j - size] + 1);
                }
                dp[i][j] = min(dp[i][j], dp[i - 1][j] + dp[1][j - 1] + 1);
                dp[i][j] = min(dp[i][j], dp[i][j - 1] + dp[i - 1][1] + 1);
            }
        }

        return dp[n][m];
    }
};