class Solution {
public:
    int checkRecord(int n) {
        const int MOD = 1e9 + 7;
        vector<vector<vector<int>>> dp(n + 1, vector<vector<int>>(2, vector<int>(3, 0)));
        dp[0][0][0] = 1;

        for (int i = 1; i <= n; ++i) {
            for (int a = 0; a < 2; ++a) {
                for (int l = 0; l < 3; ++l) {
                    // Add 'P'
                    dp[i][a][0] = (dp[i][a][0] + dp[i-1][a][l]) % MOD;
                    // Add 'A'
                    if (a > 0) {
                        dp[i][a][0] = (dp[i][a][0] + dp[i-1][a-1][l]) % MOD;
                    }
                    // Add 'L'
                    if (l > 0) {
                        dp[i][a][l] = (dp[i][a][l] + dp[i-1][a][l-1]) % MOD;
                    }
                }
            }
        }

        int result = 0;
        for (int a = 0; a < 2; ++a) {
            for (int l = 0; l < 3; ++l) {
                result = (result + dp[n][a][l]) % MOD;
            }
        }
        return result;
    }
};