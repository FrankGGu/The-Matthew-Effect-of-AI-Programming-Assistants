#include <stdio.h>
#include <stdlib.h>
#include <string.h>

int minDistance(char *s1, char *s2) {
    int m = strlen(s1), n = strlen(s2);
    int **dp = (int **)malloc((m + 1) * sizeof(int *));
    for (int i = 0; i <= m; i++) {
        dp[i] = (int *)malloc((n + 1) * sizeof(int));
    }

    for (int i = 0; i <= m; i++) {
        for (int j = 0; j <= n; j++) {
            if (i == 0 && j == 0) {
                dp[i][j] = 0;
            } else if (i == 0) {
                dp[i][j] = dp[i][j - 1] + s2[j - 1];
            } else if (j == 0) {
                dp[i][j] = dp[i - 1][j] + s1[i - 1];
            } else {
                if (s1[i - 1] == s2[j - 1]) {
                    dp[i][j] = dp[i - 1][j - 1];
                } else {
                    dp[i][j] = fmin(dp[i - 1][j] + s1[i - 1], dp[i][j - 1] + s2[j - 1]);
                }
            }
        }
    }

    int result = dp[m][n];
    for (int i = 0; i <= m; i++) {
        free(dp[i]);
    }
    free(dp);
    return result;
}

int minimumDeleteSum(char *s1, char *s2) {
    return minDistance(s1, s2);
}