#include <stdio.h>
#include <stdlib.h>

int cmp(const void *a, const void *b) {
    return (*(int*)a - *(int*)b);
}

int profitableSchemes(int* security, int securitySize, int* time, int timeSize, int profit, int* profits, int profitsSize) {
    int** dp = (int**)malloc((securitySize + 1) * sizeof(int*));
    for (int i = 0; i <= securitySize; i++) {
        dp[i] = (int*)malloc((time[timeSize - 1] + 1) * sizeof(int));
        for (int j = 0; j <= time[timeSize - 1]; j++) {
            dp[i][j] = 0;
        }
    }

    for (int i = 0; i <= securitySize; i++) {
        dp[i][0] = 1;
    }

    for (int i = 1; i <= securitySize; i++) {
        for (int j = 1; j <= time[timeSize - 1]; j++) {
            dp[i][j] = dp[i - 1][j];
            if (j >= time[i - 1]) {
                dp[i][j] += dp[i - 1][j - time[i - 1]];
            }
        }
    }

    int result = 0;
    for (int i = 0; i <= securitySize; i++) {
        result += dp[i][time[timeSize - 1]];
    }

    for (int i = 0; i <= securitySize; i++) {
        free(dp[i]);
    }
    free(dp);

    return result;
}