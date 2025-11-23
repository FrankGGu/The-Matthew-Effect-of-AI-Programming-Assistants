class Solution {
public:
    int maxProfit(vector<int>& prices) {
        int n = prices.size();
        if (n < 2) return 0;

        vector<vector<int>> dp(n, vector<int>(5, 0));

        for (int i = 0; i < n; ++i) {
            dp[i][0] = (i == 0) ? 0 : dp[i - 1][0];
            dp[i][1] = (i == 0) ? -prices[i] : max(dp[i - 1][1], dp[i - 1][0] - prices[i]);
            dp[i][2] = (i == 0) ? 0 : max(dp[i - 1][2], dp[i - 1][1] + prices[i]);
            dp[i][3] = (i == 0) ? -prices[i] : max(dp[i - 1][3], dp[i - 1][2] - prices[i]);
            dp[i][4] = (i == 0) ? 0 : max(dp[i - 1][4], dp[i - 1][3] + prices[i]);
        }

        return dp[n - 1][4];
    }
};