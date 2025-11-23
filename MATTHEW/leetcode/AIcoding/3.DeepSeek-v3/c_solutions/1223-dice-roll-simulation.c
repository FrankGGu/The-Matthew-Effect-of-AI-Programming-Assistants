int dieSimulator(int n, int* rollMax, int rollMaxSize) {
    long mod = 1000000007;
    long dp[n + 1][6][16];

    for (int i = 0; i <= n; i++) {
        for (int j = 0; j < 6; j++) {
            for (int k = 0; k <= 15; k++) {
                dp[i][j][k] = 0;
            }
        }
    }

    for (int j = 0; j < 6; j++) {
        dp[1][j][1] = 1;
    }

    for (int i = 2; i <= n; i++) {
        for (int j = 0; j < 6; j++) {
            for (int k = 1; k <= rollMax[j]; k++) {
                if (k > 1) {
                    dp[i][j][k] = dp[i - 1][j][k - 1];
                } else {
                    for (int p = 0; p < 6; p++) {
                        if (p == j) continue;
                        for (int q = 1; q <= rollMax[p]; q++) {
                            dp[i][j][k] = (dp[i][j][k] + dp[i - 1][p][q]) % mod;
                        }
                    }
                }
            }
        }
    }

    long result = 0;
    for (int j = 0; j < 6; j++) {
        for (int k = 1; k <= rollMax[j]; k++) {
            result = (result + dp[n][j][k]) % mod;
        }
    }

    return (int)result;
}