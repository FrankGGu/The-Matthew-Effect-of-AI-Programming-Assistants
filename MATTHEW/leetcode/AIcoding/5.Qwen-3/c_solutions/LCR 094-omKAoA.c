#include <stdio.h>
#include <stdlib.h>
#include <string.h>

int minCut(char *s) {
    int n = strlen(s);
    int **dp = (int **)malloc((n + 1) * sizeof(int *));
    for (int i = 0; i <= n; i++) {
        dp[i] = (int *)malloc(n * sizeof(int));
    }

    for (int i = 0; i < n; i++) {
        dp[i][i] = 0;
    }

    for (int length = 2; length <= n; length++) {
        for (int i = 0; i <= n - length; i++) {
            int j = i + length - 1;
            if (s[i] == s[j]) {
                if (j - i == 1) {
                    dp[i][j] = 0;
                } else {
                    dp[i][j] = dp[i + 1][j - 1];
                }
            } else {
                dp[i][j] = INT_MAX;
                for (int k = i; k < j; k++) {
                    if (dp[i][k] != INT_MAX && dp[k + 1][j] != INT_MAX) {
                        dp[i][j] = fmin(dp[i][j], dp[i][k] + dp[k + 1][j] + 1);
                    }
                }
            }
        }
    }

    int result = dp[0][n - 1];

    for (int i = 0; i <= n; i++) {
        free(dp[i]);
    }
    free(dp);

    return result;
}