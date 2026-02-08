class Solution {
public:
    int minimumCoins(vector<int>& prices) {
        int n = prices.size();
        vector<int> dp(n + 1, INT_MAX);
        dp[n] = 0;
        for (int i = n - 1; i >= 0; --i) {
            for (int j = i + 1; j <= min(2 * i + 2, n); ++j) {
                if (dp[j] != INT_MAX) {
                    dp[i] = min(dp[i], prices[i] + dp[j]);
                }
            }
        }
        return dp[0];
    }
};