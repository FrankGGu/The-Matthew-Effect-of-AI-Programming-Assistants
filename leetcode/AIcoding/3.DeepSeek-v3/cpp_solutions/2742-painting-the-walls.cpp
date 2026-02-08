class Solution {
public:
    int paintWalls(vector<int>& cost, vector<int>& time) {
        int n = cost.size();
        vector<int> dp(n + 1, 1e9);
        dp[0] = 0;
        for (int i = 0; i < n; ++i) {
            for (int j = n; j >= 0; --j) {
                int new_j = min(n, j + time[i] + 1);
                dp[new_j] = min(dp[new_j], dp[j] + cost[i]);
            }
        }
        return dp[n];
    }
};