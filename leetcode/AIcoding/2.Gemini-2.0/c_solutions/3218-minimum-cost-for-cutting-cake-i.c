#include <stdio.h>
#include <stdlib.h>
#include <string.h>

int minCost(int n, int* cuts, int cutsSize) {
    int* newCuts = (int*)malloc(sizeof(int) * (cutsSize + 2));
    newCuts[0] = 0;
    for (int i = 0; i < cutsSize; i++) {
        newCuts[i + 1] = cuts[i];
    }
    newCuts[cutsSize + 1] = n;
    qsort(newCuts, cutsSize + 2, sizeof(int), compare);

    int** dp = (int**)malloc(sizeof(int*) * (cutsSize + 2));
    for (int i = 0; i < cutsSize + 2; i++) {
        dp[i] = (int*)malloc(sizeof(int) * (cutsSize + 2));
        for (int j = 0; j < cutsSize + 2; j++) {
            dp[i][j] = 0;
        }
    }

    for (int len = 2; len < cutsSize + 2; len++) {
        for (int i = 0; i < cutsSize + 2 - len; i++) {
            int j = i + len;
            dp[i][j] = 2147483647;
            for (int k = i + 1; k < j; k++) {
                dp[i][j] = min(dp[i][j], dp[i][k] + dp[k][j] + newCuts[j] - newCuts[i]);
            }
        }
    }

    int result = dp[0][cutsSize + 1];

    for (int i = 0; i < cutsSize + 2; i++) {
        free(dp[i]);
    }
    free(dp);
    free(newCuts);

    return result;
}

int compare(const void* a, const void* b) {
    return *(int*)a - *(int*)b;
}

int min(int a, int b) {
    return (a < b) ? a : b;
}