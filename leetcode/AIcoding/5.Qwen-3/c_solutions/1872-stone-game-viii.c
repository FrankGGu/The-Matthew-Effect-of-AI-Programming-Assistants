#include <stdio.h>
#include <stdlib.h>

int* stoneGameVIII(int* piles, int pilesSize, int* returnSize) {
    int n = pilesSize;
    int* dp = (int*)malloc(n * sizeof(int));
    int* res = (int*)malloc(n * sizeof(int));
    dp[n - 1] = piles[n - 1];
    for (int i = n - 2; i >= 0; i--) {
        dp[i] = dp[i + 1] + piles[i];
    }
    res[0] = dp[0];
    for (int i = 1; i < n; i++) {
        res[i] = fmax(res[i - 1], dp[i]);
    }
    *returnSize = n;
    return res;
}