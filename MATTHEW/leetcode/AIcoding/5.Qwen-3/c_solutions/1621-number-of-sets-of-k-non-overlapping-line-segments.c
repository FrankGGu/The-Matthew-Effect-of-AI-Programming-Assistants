#include <stdio.h>
#include <stdlib.h>

int numberOfSets(int n, int k) {
    int** dp = (int**)malloc((n + 1) * sizeof(int*));
    for (int i = 0; i <= n; i++) {
        dp[i] = (int*)malloc((k + 1) * sizeof(int));
    }

    for (int i = 0; i <= n; i++) {
        dp[i][0] = 1;
    }

    for (int j = 1; j <= k; j++) {
        dp[0][j] = 0;
    }

    for (int i = 1; i <= n; i++) {
        for (int j = 1; j <= k; j++) {
            dp[i][j] = dp[i - 1][j];
            if (i >= 1) {
                dp[i][j] += dp[i - 1][j - 1];
            }
            if (i >= 2) {
                dp[i][j] += dp[i - 2][j - 1];
            }
        }
    }

    int result = dp[n][k];

    for (int i = 0; i <= n; i++) {
        free(dp[i]);
    }
    free(dp);

    return result;
}