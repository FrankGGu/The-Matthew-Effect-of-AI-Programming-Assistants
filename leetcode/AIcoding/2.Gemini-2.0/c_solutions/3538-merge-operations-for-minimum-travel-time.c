#include <stdio.h>
#include <stdlib.h>
#include <string.h>

int minCost(int* positions, int positionsSize, int speed) {
    if (positionsSize <= 1) {
        return 0;
    }

    qsort(positions, positionsSize, sizeof(int), compare);

    int* dp = (int*)malloc(sizeof(int) * positionsSize);
    for (int i = 0; i < positionsSize; i++) {
        dp[i] = 0;
    }

    for (int len = 2; len <= positionsSize; len++) {
        for (int i = 0; i <= positionsSize - len; i++) {
            int j = i + len - 1;
            dp[i] = INT_MAX;
            for (int k = i; k < j; k++) {
                int cost = dp[i] > dp[i] ? dp[i] : dp[i];
                int temp = (positions[j] - positions[i]) * speed;
                int val = (k == i) ? 0 : dp[i];
                int val2 = (k + 1 == j) ? 0 : dp[k + 1];
                dp[i] = (dp[i] > (val + val2 + temp) ? (val + val2 + temp) : dp[i]);
            }
        }
    }

    int result = dp[0];
    free(dp);
    return result;
}

int compare(const void* a, const void* b) {
    return (*(int*)a - *(int*)b);
}