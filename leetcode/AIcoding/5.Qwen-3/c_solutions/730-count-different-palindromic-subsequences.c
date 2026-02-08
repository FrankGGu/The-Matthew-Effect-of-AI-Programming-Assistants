#include <stdio.h>
#include <stdlib.h>
#include <string.h>

int countDifferentPalindromicSubsequences(char *s) {
    int n = strlen(s);
    int **dp = (int **)malloc(n * sizeof(int *));
    for (int i = 0; i < n; i++) {
        dp[i] = (int *)calloc(n, sizeof(int));
    }

    for (int i = 0; i < n; i++) {
        dp[i][i] = 1;
    }

    for (int length = 2; length <= n; length++) {
        for (int i = 0; i <= n - length; i++) {
            int j = i + length - 1;
            if (s[i] == s[j]) {
                if (length == 2) {
                    dp[i][j] = 2;
                } else {
                    dp[i][j] = dp[i + 1][j - 1] * 2;
                    if (s[i + 1] == s[j - 1]) {
                        dp[i][j] += 2;
                    } else if (s[i + 1] == s[j]) {
                        dp[i][j] += 1;
                    } else if (s[i] == s[j - 1]) {
                        dp[i][j] += 1;
                    }
                }
            } else {
                dp[i][j] = dp[i + 1][j] + dp[i][j - 1] - dp[i + 1][j - 1];
            }
        }
    }

    int result = dp[0][n - 1];
    for (int i = 0; i < n; i++) {
        free(dp[i]);
    }
    free(dp);
    return result;
}