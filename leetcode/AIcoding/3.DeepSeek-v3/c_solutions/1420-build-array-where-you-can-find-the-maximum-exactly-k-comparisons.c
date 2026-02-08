int numOfArrays(int n, int m, int k) {
    if (k == 0 || k > m) return 0;

    long long dp[n+1][m+1][k+1];
    long long mod = 1000000007;

    for (int i = 0; i <= n; i++) {
        for (int j = 0; j <= m; j++) {
            for (int l = 0; l <= k; l++) {
                dp[i][j][l] = 0;
            }
        }
    }

    for (int j = 1; j <= m; j++) {
        dp[1][j][1] = 1;
    }

    for (int i = 2; i <= n; i++) {
        for (int j = 1; j <= m; j++) {
            for (int l = 1; l <= k; l++) {
                dp[i][j][l] = (dp[i][j][l] + dp[i-1][j][l] * j) % mod;

                for (int prev = 1; prev < j; prev++) {
                    dp[i][j][l] = (dp[i][j][l] + dp[i-1][prev][l-1]) % mod;
                }
            }
        }
    }

    long long res = 0;
    for (int j = 1; j <= m; j++) {
        res = (res + dp[n][j][k]) % mod;
    }

    return res;
}