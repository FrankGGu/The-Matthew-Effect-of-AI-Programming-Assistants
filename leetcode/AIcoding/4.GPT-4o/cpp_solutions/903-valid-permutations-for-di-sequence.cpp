class Solution {
public:
    int numPermsDISequence(string S) {
        int n = S.size();
        vector<vector<int>> dp(n + 1, vector<int>(n + 1, 0));
        const int MOD = 1e9 + 7;

        dp[0][0] = 1;

        for (int i = 1; i <= n; ++i) {
            for (int j = 0; j <= i; ++j) {
                if (S[i - 1] == 'I') {
                    if (j > 0) dp[i][j] = (dp[i][j] + dp[i - 1][j - 1]) % MOD;
                    dp[i][j] = (dp[i][j] + dp[i - 1][j]) % MOD;
                } else {
                    dp[i][j] = (dp[i][j] + dp[i - 1][j]) % MOD;
                    if (j < i) dp[i][j] = (dp[i][j] + dp[i - 1][j + 1]) % MOD;
                }
            }
        }

        return dp[n][0];
    }
};