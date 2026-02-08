#include <stdio.h>
#include <stdlib.h>

int max(int a, int b) {
    return a > b ? a : b;
}

int maxSumAfterPartitioning(int* arr, int arrSize, int k) {
    int* dp = (int*)malloc((arrSize + 1) * sizeof(int));
    for (int i = 0; i <= arrSize; i++) {
        dp[i] = 0;
    }

    for (int i = 1; i <= arrSize; i++) {
        int maxVal = 0;
        for (int j = 1; j <= k && i - j >= 0; j++) {
            maxVal = max(maxVal, arr[i - j]);
            dp[i] = max(dp[i], dp[i - j] + maxVal);
        }
    }

    int result = dp[arrSize];
    free(dp);
    return result;
}