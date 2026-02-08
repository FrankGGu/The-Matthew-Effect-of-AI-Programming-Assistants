int numberOfStableArrays(int zero, int one, int limit) {
    int MOD = 1000000007;
    int dp[zero + 1][one + 1][2];

    for (int i = 0; i <= zero; i++) {
        for (int j = 0; j <= one; j++) {
            dp[i][j][0] = 0;
            dp[i][j][1] = 0;
        }
    }

    if (zero > 0) dp[1][0][0] = 1;
    if (one > 0) dp[0][1][1] = 1;

    for (int i = 0; i <= zero; i++) {
        for (int j = 0; j <= one; j++) {
            if (i == 0 && j == 0) continue;

            if (i > 0) {
                if (i == 1 && j == 0) {
                    dp[i][j][0] = 1;
                } else {
                    dp[i][j][0] = (dp[i][j][0] + dp[i - 1][j][1]) % MOD;
                    if (i > limit) {
                        dp[i][j][0] = (dp[i][j][0] - dp[i - limit - 1][j][1] + MOD) % MOD;
                    }
                    if (j > 0) {
                        dp[i][j][0] = (dp[i][j][0] + dp[i - 1][j][0]) % MOD;
                        if (i > limit) {
                            dp[i][j][0] = (dp[i][j][0] - dp[i - limit - 1][j][0] + MOD) % MOD;
                        }
                    }
                }
            }

            if (j > 0) {
                if (i == 0 && j == 1) {
                    dp[i][j][1] = 1;
                } else {
                    dp[i][j][1] = (dp[i][j][1] + dp[i][j - 1][0]) % MOD;
                    if (j > limit) {
                        dp[i][j][1] = (dp[i][j][1] - dp[i][j - limit - 1][0] + MOD) % MOD;
                    }
                    if (i > 0) {
                        dp[i][j][1] = (dp[i][j][1] + dp[i][j - 1][1]) % MOD;
                        if (j > limit) {
                            dp[i][j][1] = (dp[i][j][1] - dp[i][j - limit - 1][1] + MOD) % MOD;
                        }
                    }
                }
            }
        }
    }

    return (dp[zero][one][0] + dp[zero][one][1]) % MOD;
}