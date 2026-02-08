#include <stdio.h>
#include <stdlib.h>
#include <string.h>

int countPalindromicSubsequences(char *s) {
    int n = strlen(s);
    int dp[n][n];
    int count[26] = {0};

    for (int i = 0; i < n; i++) {
        count[s[i] - 'a']++;
    }

    for (int i = 0; i < n; i++) {
        dp[i][i] = 1;
    }

    for (int length = 2; length <= n; length++) {
        for (int i = 0; j = i + length - 1; i++) {
            if (s[i] == s[j]) {
                if (length == 2) {
                    dp[i][j] = 2;
                } else {
                    dp[i][j] = dp[i + 1][j - 1] * 2 + 2;
                }
            } else {
                dp[i][j] = dp[i + 1][j] + dp[i][j - 1] - dp[i + 1][j - 1];
            }
        }
    }

    return dp[0][n - 1];
}