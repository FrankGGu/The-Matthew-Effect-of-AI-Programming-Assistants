class Solution {
public:
    int minTimeToCook(vector<int>& time, vector<int>& order) {
        int n = order.size();
        int m = time.size();
        vector<int> dp(n + 1, INT_MAX);
        dp[0] = 0;

        for (int i = 1; i <= n; ++i) {
            for (int j = 0; j < m; ++j) {
                if (order[i - 1] - 1 == j) {
                    dp[i] = min(dp[i], dp[i - 1] + time[j]);
                }
            }
        }

        return dp[n];
    }
};