#include <stdio.h>
#include <stdlib.h>
#include <string.h>

#define MOD 1000000007

int numberOfWays(char *s) {
    int n = strlen(s);
    int lcp[n + 1][n + 1];
    memset(lcp, 0, sizeof(lcp));

    for (int i = n - 1; i >= 0; i--) {
        for (int j = n - 1; j >= 0; j--) {
            if (s[i] == s[j]) {
                lcp[i][j] = lcp[i + 1][j + 1] + 1;
            } else {
                lcp[i][j] = 0;
            }
        }
    }

    int dp[n + 1];
    memset(dp, 0, sizeof(dp));
    dp[0] = 1;

    for (int i = 1; i <= n; i++) {
        for (int j = 1; j <= i; j++) {
            if (s[i - j] == '0') continue;
            if (i - j == 0) {
                dp[i] = (dp[i] + dp[i - j]) % MOD;
                continue;
            }
            int len = j;
            int prev_len = i - (i - j);
            int common = lcp[i - j][i - j - prev_len];
            if (common >= len) {
                if (prev_len >= len) {
                    dp[i] = (dp[i] + dp[i - j]) % MOD;
                }

            } else {
                if (s[i - j + common] > s[i - j - prev_len + common]) {
                    dp[i] = (dp[i] + dp[i - j]) % MOD;
                }
            }

        }
    }

    return dp[n];
}