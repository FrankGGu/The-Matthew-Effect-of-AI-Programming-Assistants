int dp[201][201][2];

int numberOfSubstrings(char* s, int k) {
    int n = strlen(s);
    memset(dp, -1, sizeof(dp));

    for (int i = 0; i < n; i++) {
        for (int j = 0; j <= k; j++) {
            dp[i][j][0] = dp[i][j][1] = 0;
        }
    }

    for (int i = n - 1; i >= 0; i--) {
        for (int j = k; j >= 0; j--) {
            for (int last = 0; last < 2; last++) {
                if (j == k) {
                    dp[i][j][last] = 1;
                    continue;
                }

                int res = 0;
                if (i + 1 < n) {
                    res = (res + dp[i + 1][j][last]) % 1000000007;
                }

                int need = (s[i] - '0') ^ last;
                if (need == 1) {
                    if (j + 1 <= k) {
                        if (i + 1 < n) {
                            res = (res + dp[i + 1][j + 1][s[i] - '0']) % 1000000007;
                        } else if (j + 1 == k) {
                            res = (res + 1) % 1000000007;
                        }
                    }
                } else {
                    if (i + 1 < n) {
                        res = (res + dp[i + 1][j][s[i] - '0']) % 1000000007;
                    } else if (j == k) {
                        res = (res + 1) % 1000000007;
                    }
                }

                dp[i][j][last] = res;
            }
        }
    }

    return dp[0][0][0];
}