class Solution {
public:
    int minimumOperations(string leaves) {
        int n = leaves.size();
        vector<vector<int>> dp(n, vector<int>(3, INT_MAX));
        dp[0][0] = (leaves[0] == 'y');
        for (int i = 1; i < n; ++i) {
            if (i >= 0) {
                dp[i][0] = dp[i-1][0] + (leaves[i] == 'y');
            }
            if (i >= 1) {
                dp[i][1] = min(dp[i-1][0], dp[i-1][1]) + (leaves[i] == 'r');
                if (i >= 2) {
                    dp[i][2] = min(dp[i-1][1], dp[i-1][2]) + (leaves[i] == 'y');
                }
            }
        }
        return dp[n-1][2];
    }
};