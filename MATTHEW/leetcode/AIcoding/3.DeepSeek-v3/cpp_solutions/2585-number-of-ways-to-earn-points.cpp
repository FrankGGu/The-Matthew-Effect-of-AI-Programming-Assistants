class Solution {
public:
    int waysToReachTarget(int target, vector<vector<int>>& types) {
        const int MOD = 1e9 + 7;
        int n = types.size();
        vector<vector<int>> dp(n + 1, vector<int>(target + 1, 0));
        dp[0][0] = 1;

        for (int i = 1; i <= n; ++i) {
            int count = types[i - 1][0];
            int mark = types[i - 1][1];
            for (int j = 0; j <= target; ++j) {
                dp[i][j] = dp[i - 1][j];
                for (int k = 1; k <= count; ++k) {
                    if (j >= k * mark) {
                        dp[i][j] = (dp[i][j] + dp[i - 1][j - k * mark]) % MOD;
                    } else {
                        break;
                    }
                }
            }
        }

        return dp[n][target];
    }
};