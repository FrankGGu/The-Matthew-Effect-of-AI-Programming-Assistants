class Solution {
public:
    int numWays(int n, int relation, int k) {
        vector<vector<int>> dp(k + 1, vector<int>(n, 0));
        dp[0][0] = 1;

        for (int i = 1; i <= k; ++i) {
            for (int j = 0; j < n; ++j) {
                if (j - 1 >= 0) dp[i][j] += dp[i - 1][j - 1];
                if (j + 1 < n) dp[i][j] += dp[i - 1][j + 1];
            }
        }
        return dp[k][relation];
    }
};