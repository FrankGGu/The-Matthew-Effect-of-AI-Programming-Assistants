#include <stdio.h>
#include <stdlib.h>

int numberOfWays(int* points, int pointsSize, int k) {
    int** dp = (int**)malloc((k + 1) * sizeof(int*));
    for (int i = 0; i <= k; i++) {
        dp[i] = (int*)malloc((pointsSize + 1) * sizeof(int));
        for (int j = 0; j <= pointsSize; j++) {
            dp[i][j] = 0;
        }
    }

    for (int j = 0; j <= pointsSize; j++) {
        dp[0][j] = 1;
    }

    for (int i = 1; i <= k; i++) {
        for (int j = 1; j <= pointsSize; j++) {
            dp[i][j] = dp[i][j - 1];
            if (points[j - 1] <= i) {
                dp[i][j] += dp[i - points[j - 1]][j - 1];
            }
        }
    }

    int result = dp[k][pointsSize];

    for (int i = 0; i <= k; i++) {
        free(dp[i]);
    }
    free(dp);

    return result;
}