#define MOD 1000000007

int countWays(char **corridor, int corridorSize) {
    int n = 0;
    for (int i = 0; i < corridorSize; i++) {
        for (int j = 0; corridor[i][j] != '\0'; j++) {
            if (corridor[i][j] == '|') n++;
        }
    }

    if (n % 2 != 0) return 0;

    long long dp[n / 2 + 1][n / 2 + 1];
    for (int i = 0; i <= n / 2; i++) {
        for (int j = 0; j <= n / 2; j++) {
            dp[i][j] = 0;
        }
    }
    dp[0][0] = 1;

    for (int i = 1; i <= n / 2; i++) {
        for (int j = 1; j <= n / 2; j++) {
            dp[i][j] = (dp[i-1][j] + dp[i][j-1]) % MOD;
        }
    }

    return dp[n / 2][n / 2];
}