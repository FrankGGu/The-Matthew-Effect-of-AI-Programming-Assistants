class Solution {
public:
    int getBonus(vector<int>& coins) {
        int n = coins.size();
        if (n == 0) return 0;

        vector<int> dp(n + 1, 0);
        for (int i = 1; i <= n; ++i) {
            dp[i] = dp[i - 1] + coins[i - 1];
            if (i >= 3) {
                dp[i] = max(dp[i], dp[i - 3] + coins[i - 1]);
            }
        }
        return dp[n];
    }
};