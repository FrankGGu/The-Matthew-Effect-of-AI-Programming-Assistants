int countWinningSequences(char* s, int k) {
    int n = strlen(s);
    long long mod = 1e9 + 7;

    long long dp[n + 1][k + 1][3];
    memset(dp, 0, sizeof(dp));

    for (int i = 0; i < 3; i++) {
        dp[0][0][i] = 1;
    }

    for (int i = 1; i <= n; i++) {
        for (int j = 0; j <= k; j++) {
            for (int last = 0; last < 3; last++) {
                for (int curr = 0; curr < 3; curr++) {
                    if (curr == last) continue;

                    int win = 0;
                    if ((curr == 0 && last == 2) || 
                        (curr == 1 && last == 0) || 
                        (curr == 2 && last == 1)) {
                        win = 1;
                    }

                    if (j >= win) {
                        dp[i][j][curr] = (dp[i][j][curr] + dp[i - 1][j - win][last]) % mod;
                    }
                }
            }
        }
    }

    long long res = 0;
    for (int last = 0; last < 3; last++) {
        res = (res + dp[n][k][last]) % mod;
    }

    return res;
}