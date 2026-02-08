class Solution {
public:
    long long maxProfit(int n, vector<int>& price) {
        vector<long long> dp(n + 1, 0);
        for (int i = 1; i <= n; ++i) {
            for (int j = 1; j <= i; ++j) {
                dp[i] = max(dp[i], dp[i - j] + price[j - 1]);
            }
        }
        return dp[n];
    }
};