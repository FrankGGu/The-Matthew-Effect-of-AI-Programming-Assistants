class Solution {
public:
    int maxProfit(int k, vector<int>& prices) {
        if (prices.empty() || k == 0) return 0;
        int n = prices.size();
        if (k >= n / 2) {
            int totalProfit = 0;
            for (int i = 1; i < n; ++i) {
                if (prices[i] > prices[i - 1]) {
                    totalProfit += prices[i] - prices[i - 1];
                }
            }
            return totalProfit;
        }

        vector<vector<int>> dp(k + 1, vector<int>(n, 0));
        for (int i = 1; i <= k; ++i) {
            int maxDiff = -prices[0];
            for (int j = 1; j < n; ++j) {
                dp[i][j] = max(dp[i][j - 1], prices[j] + maxDiff);
                maxDiff = max(maxDiff, dp[i - 1][j] - prices[j]);
            }
        }
        return dp[k][n - 1];
    }
};