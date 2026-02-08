#include <stdio.h>
#include <stdlib.h>
#include <string.h>

int max(int a, int b) {
    return (a > b) ? a : b;
}

int maxSumAfterPartitioning(int* arr, int arrSize, int k) {
    int dp[arrSize + 1];
    dp[0] = 0;

    for (int i = 1; i <= arrSize; i++) {
        int max_val = 0;
        int best = 0;
        for (int j = 1; j <= k && i - j >= 0; j++) {
            max_val = max(max_val, arr[i - j]);
            best = max(best, dp[i - j] + max_val * j);
        }
        dp[i] = best;
    }

    return dp[arrSize];
}