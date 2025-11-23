#define MOD 1000000007

int checkRecord(int n){
    long long dp[n + 1][3][2];
    memset(dp, 0, sizeof(dp));
    dp[0][0][0] = 1;

    for (int i = 1; i <= n; i++) {
        for (int j = 0; j < 3; j++) {
            for (int k = 0; k < 2; k++) {
                dp[i][j][k] = dp[i - 1][j][k] % MOD;
                if (j > 0) {
                    dp[i][j][k] = (dp[i][j][k] + dp[i - 1][j - 1][k]) % MOD;
                }
                if (k == 0) {
                    dp[i][j][1] = (dp[i][j][1] + dp[i - 1][j][0]) % MOD;
                }
            }
        }
    }

    long long result = 0;
    for (int j = 0; j < 3; j++) {
        for (int k = 0; k < 2; k++) {
            result = (result + dp[n][j][k]) % MOD;
        }
    }

    return (int)result;
}