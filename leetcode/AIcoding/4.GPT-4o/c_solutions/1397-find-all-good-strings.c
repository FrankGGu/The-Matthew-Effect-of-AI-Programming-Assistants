#define MOD 1000000007

int countGoodStrings(int n, int minValue, int maxValue, int zero, int one) {
    long long dp[n + 1][maxValue + 1];
    memset(dp, 0, sizeof(dp));
    dp[0][0] = 1;

    for (int i = 0; i < n; i++) {
        for (int j = 0; j <= maxValue; j++) {
            if (dp[i][j]) {
                if (j + zero <= maxValue) {
                    dp[i + 1][j + zero] = (dp[i + 1][j + zero] + dp[i][j]) % MOD;
                }
                if (j + one <= maxValue) {
                    dp[i + 1][j + one] = (dp[i + 1][j + one] + dp[i][j]) % MOD;
                }
            }
        }
    }

    long long result = 0;
    for (int j = minValue; j <= maxValue; j++) {
        result = (result + dp[n][j]) % MOD;
    }

    return (int)result;
}