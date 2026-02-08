class Solution {
public:
    vector<int> simulateDiceRolls(int n, int k, int target) {
        vector<vector<int>> dp(n + 1, vector<int>(target + 1, 0));
        dp[0][0] = 1;

        for (int i = 1; i <= n; ++i) {
            for (int j = 1; j <= target; ++j) {
                for (int face = 1; face <= k; ++face) {
                    if (j - face >= 0) {
                        dp[i][j] = (dp[i][j] + dp[i - 1][j - face]) % 1000000007;
                    }
                }
            }
        }

        return dp[n][target];
    }
};