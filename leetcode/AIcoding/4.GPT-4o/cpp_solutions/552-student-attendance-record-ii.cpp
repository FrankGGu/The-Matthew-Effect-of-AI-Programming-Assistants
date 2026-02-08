class Solution {
public:
    int mod = 1e9 + 7;

    int checkRecord(int n) {
        long long dp[n + 1][3][2] = {};
        dp[0][0][0] = 1;

        for (int i = 1; i <= n; ++i) {
            for (int j = 0; j < 3; ++j) {
                for (int k = 0; k < 2; ++k) {
                    dp[i][0][k] = (dp[i][0][k] + dp[i - 1][j][k]) % mod;
                    if (j < 2) {
                        dp[i][j + 1][k] = (dp[i][j + 1][k] + dp[i - 1][j][k]) % mod;
                    }
                    if (k == 0) {
                        dp[i][0][1] = (dp[i][0][1] + dp[i - 1][j][k]) % mod;
                    }
                }
            }
        }

        long long result = 0;
        for (int j = 0; j < 3; ++j) {
            for (int k = 0; k < 2; ++k) {
                result = (result + dp[n][j][k]) % mod;
            }
        }
        return result;
    }
};