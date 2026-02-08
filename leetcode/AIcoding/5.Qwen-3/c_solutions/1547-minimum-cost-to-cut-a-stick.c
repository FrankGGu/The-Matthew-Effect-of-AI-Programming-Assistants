#include <stdio.h>
#include <stdlib.h>

int compare(const void *a, const void *b) {
    return (*(int*)a - *(int*)b);
}

int minCost(int n, int cutsSize, int* cuts) {
    qsort(cuts, cutsSize, sizeof(int), compare);
    int* newCuts = (int*)malloc((cutsSize + 2) * sizeof(int));
    newCuts[0] = 0;
    for (int i = 0; i < cutsSize; i++) {
        newCuts[i + 1] = cuts[i];
    }
    newCuts[cutsSize + 1] = n;
    cutsSize += 2;
    int** dp = (int**)malloc((cutsSize) * sizeof(int*));
    for (int i = 0; i < cutsSize; i++) {
        dp[i] = (int*)malloc((cutsSize) * sizeof(int));
    }
    for (int i = 0; i < cutsSize; i++) {
        dp[i][i] = 0;
    }
    for (int length = 2; length < cutsSize; length++) {
        for (int i = 0; i < cutsSize - length; i++) {
            int j = i + length;
            dp[i][j] = INT_MAX;
            for (int k = i + 1; k < j; k++) {
                int cost = dp[i][k] + dp[k][j] + newCuts[j] - newCuts[i];
                if (cost < dp[i][j]) {
                    dp[i][j] = cost;
                }
            }
        }
    }
    int result = dp[0][cutsSize - 1];
    for (int i = 0; i < cutsSize; i++) {
        free(dp[i]);
    }
    free(dp);
    free(newCuts);
    return result;
}