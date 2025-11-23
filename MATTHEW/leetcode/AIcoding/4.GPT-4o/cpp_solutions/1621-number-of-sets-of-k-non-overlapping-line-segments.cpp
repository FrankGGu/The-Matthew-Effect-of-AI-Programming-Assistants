class Solution {
public:
    int numberOfSets(int n, int k) {
        vector<vector<int>> dp(k + 1, vector<int>(n + 1, 0));
        dp[0][0] = 1;

        for (int i = 1; i <= n; ++i) {
            for (int j = min(i, k); j >= 1; --j) {
                dp[j][i] = (dp[j][i - 1] + dp[j - 1][i - 2]) % 1000000007;
            }
            dp[0][i] = 1;
        }

        return dp[k][n];
    }
};