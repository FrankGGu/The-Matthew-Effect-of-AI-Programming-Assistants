class Solution {
public:
    int paintWalls(vector<int>& costs, int n) {
        if (n == 0) return 0;
        vector<int> dp(n + 1, 0);
        for (int i = 1; i <= n; ++i) {
            dp[i] = INT_MAX;
            for (int j = 0; j < 3; ++j) {
                dp[i] = min(dp[i], costs[j] + dp[i - 1]);
            }
        }
        return dp[n];
    }
};