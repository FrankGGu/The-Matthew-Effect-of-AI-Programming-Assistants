#include <stdio.h>
#include <stdlib.h>
#include <limits.h>

int *bridgeBuilding(int *stones, int stonesSize) {
    int *result = (int *)malloc(stonesSize * sizeof(int));
    int *dp = (int *)malloc((stonesSize + 1) * sizeof(int));
    int *prev = (int *)malloc((stonesSize + 1) * sizeof(int));

    for (int i = 0; i <= stonesSize; i++) {
        dp[i] = INT_MAX;
        prev[i] = -1;
    }

    dp[0] = 0;

    for (int i = 1; i <= stonesSize; i++) {
        for (int j = 0; j < i; j++) {
            if (dp[j] != INT_MAX && abs(stones[i - 1] - stones[j]) <= 3) {
                if (dp[j] + 1 < dp[i]) {
                    dp[i] = dp[j] + 1;
                    prev[i] = j;
                }
            }
        }
    }

    int idx = stonesSize;
    int count = 0;
    while (idx != -1) {
        count++;
        idx = prev[idx];
    }

    result = (int *)malloc(count * sizeof(int));
    idx = stonesSize;
    int k = count - 1;
    while (idx != -1) {
        result[k--] = stones[idx - 1];
        idx = prev[idx];
    }

    free(dp);
    free(prev);
    return result;
}