class Solution {
public:
    int maxTaxiEarnings(int n, vector<vector<int>>& rides) {
        vector<long> dp(n + 1, 0);
        for (const auto& ride : rides) {
            dp[ride[1]] = max(dp[ride[1]], (long)ride[1] - ride[0] + ride[2] + dp[ride[0]]);
        }
        for (int i = 1; i <= n; ++i) {
            dp[i] = max(dp[i], dp[i - 1]);
        }
        return dp[n];
    }
};