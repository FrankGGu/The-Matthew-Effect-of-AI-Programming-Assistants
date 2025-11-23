int colorTheGrid(int m, int n) {
    const int MOD = 1000000007;
    long long dp[3] = {0}, dp_prev[3] = {0};
    int i, j, k;

    for (i = 0; i < 3; i++) {
        dp[i] = 1;
    }

    for (j = 1; j <= n; j++) {
        for (i = 0; i < 3; i++) {
            dp_prev[i] = dp[i];
            dp[i] = 0;
        }
        for (i = 0; i < 3; i++) {
            for (k = 0; k < 3; k++) {
                if (i != k) {
                    dp[k] = (dp[k] + dp_prev[i]) % MOD;
                }
            }
        }
        for (i = 0; i < 3; i++) {
            dp[i] = (dp[i] * 2) % MOD;
        }
    }

    long long result = 0;
    for (i = 0; i < 3; i++) {
        result = (result + dp[i]) % MOD;
    }

    return (int)result;
}