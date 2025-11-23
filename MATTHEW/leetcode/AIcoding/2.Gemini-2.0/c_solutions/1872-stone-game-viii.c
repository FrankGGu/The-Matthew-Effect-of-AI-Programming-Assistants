#include <stdio.h>
#include <stdlib.h>
#include <string.h>

int stoneGameVIII(int* stones, int stonesSize) {
    int* prefixSum = (int*)malloc((stonesSize + 1) * sizeof(int));
    prefixSum[0] = 0;
    for (int i = 0; i < stonesSize; i++) {
        prefixSum[i + 1] = prefixSum[i] + stones[i];
    }

    int* dp = (int*)malloc((stonesSize + 1) * sizeof(int));
    dp[stonesSize] = prefixSum[stonesSize];

    for (int i = stonesSize - 1; i >= 2; i--) {
        dp[i] = (prefixSum[i] - dp[i + 1] > -2147483647 && prefixSum[i] - dp[i + 1] < 2147483647) ? prefixSum[i] - dp[i + 1] : (prefixSum[i] - dp[i + 1] > 0 ? 2147483647 : -2147483647);
        if(dp[i] < dp[i+1]){
            dp[i] = dp[i+1];
        }
    }

    int result = dp[2];

    free(prefixSum);
    free(dp);

    return result;
}