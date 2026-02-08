class Solution {
public:
    int minDays(int n) {
        vector<int> dp(n + 1, INT_MAX);
        dp[0] = 0;

        for (int i = 1; i <= n; ++i) {
            dp[i] = min(dp[i], dp[i - 1] + 1);
            if (i >= 2) dp[i] = min(dp[i], dp[i / 2] + 1 + (i % 2));
            if (i >= 3) dp[i] = min(dp[i], dp[i / 3] + 1 + (i % 3));
        }

        return dp[n];
    }
};