class Solution {
public:
    int distinctSequences(int n) {
        const int MOD = 1e9 + 7;
        vector<vector<int>> dp(n + 1, vector<int>(7, 0));
        dp[0][0] = 1;

        for (int i = 1; i <= n; ++i) {
            for (int j = 1; j <= 6; ++j) {
                for (int k = 0; k <= 6; ++k) {
                    if (j != k && (i == 1 || (j != i - 1))) {
                        dp[i][j] = (dp[i][j] + dp[i - 1][k]) % MOD;
                    }
                }
            }
        }

        int result = 0;
        for (int j = 1; j <= 6; ++j) {
            result = (result + dp[n][j]) % MOD;
        }

        return result;
    }
};