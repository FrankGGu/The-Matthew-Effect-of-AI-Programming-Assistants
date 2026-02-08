class Solution {
public:
    long long sellingWood(int m, int n, vector<vector<int>>& prices) {
        vector<vector<long long>> dp(m + 1, vector<long long>(n + 1, 0));
        for (const auto& price : prices) {
            int h = price[0], w = price[1], p = price[2];
            if (h <= m && w <= n) {
                dp[h][w] = max(dp[h][w], (long long)p);
            }
        }

        for (int i = 1; i <= m; ++i) {
            for (int j = 1; j <= n; ++j) {
                for (int k = 1; k <= i / 2; ++k) {
                    dp[i][j] = max(dp[i][j], dp[k][j] + dp[i - k][j]);
                }
                for (int k = 1; k <= j / 2; ++k) {
                    dp[i][j] = max(dp[i][j], dp[i][k] + dp[i][j - k]);
                }
            }
        }

        return dp[m][n];
    }
};