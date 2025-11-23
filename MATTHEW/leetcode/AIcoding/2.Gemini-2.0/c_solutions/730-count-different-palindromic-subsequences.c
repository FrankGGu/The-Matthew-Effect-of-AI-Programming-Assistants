#include <stdio.h>
#include <stdlib.h>
#include <string.h>

#define MOD 1000000007

int countPalindromicSubsequences(char *s) {
    int n = strlen(s);
    int dp[n][n][4];
    memset(dp, 0, sizeof(dp));

    for (int i = 0; i < n; i++) {
        for (int a = 0; a < 4; a++) {
            if (s[i] == 'a' + a) {
                dp[i][i][a] = 1;
            }
        }
    }

    for (int len = 2; len <= n; len++) {
        for (int i = 0; i <= n - len; i++) {
            int j = i + len - 1;
            for (int a = 0; a < 4; a++) {
                if (s[i] == 'a' + a && s[j] == 'a' + a) {
                    dp[i][j][a] = 2;
                    for (int b = 0; b < 4; b++) {
                        dp[i][j][a] = (dp[i][j][a] + dp[i + 1][j - 1][b]) % MOD;
                    }
                } else if (s[i] == 'a' + a) {
                    dp[i][j][a] = dp[i][j - 1][a];
                } else if (s[j] == 'a' + a) {
                    dp[i][j][a] = dp[i + 1][j][a];
                } else {
                    dp[i][j][a] = dp[i + 1][j - 1][a];
                }
            }
        }
    }

    int ans = 0;
    for (int a = 0; a < 4; a++) {
        ans = (ans + dp[0][n - 1][a]) % MOD;
    }

    return ans;
}