#include <stdio.h>
#include <stdlib.h>
#include <string.h>

int stoneGameV(int* stoneValue, int stoneValueSize) {
    int* prefixSum = (int*)malloc((stoneValueSize + 1) * sizeof(int));
    prefixSum[0] = 0;
    for (int i = 0; i < stoneValueSize; i++) {
        prefixSum[i + 1] = prefixSum[i] + stoneValue[i];
    }

    int** dp = (int**)malloc(stoneValueSize * sizeof(int*));
    for (int i = 0; i < stoneValueSize; i++) {
        dp[i] = (int*)malloc(stoneValueSize * sizeof(int));
        for (int j = 0; j < stoneValueSize; j++) {
            dp[i][j] = 0;
        }
    }

    for (int len = 2; len <= stoneValueSize; len++) {
        for (int i = 0; i <= stoneValueSize - len; i++) {
            int j = i + len - 1;
            for (int k = i; k < j; k++) {
                int leftSum = prefixSum[k + 1] - prefixSum[i];
                int rightSum = prefixSum[j + 1] - prefixSum[k + 1];
                if (leftSum < rightSum) {
                    dp[i][j] = fmax(dp[i][j], leftSum + dp[i][k]);
                } else if (leftSum > rightSum) {
                    dp[i][j] = fmax(dp[i][j], rightSum + dp[k + 1][j]);
                } else {
                    dp[i][j] = fmax(dp[i][j], leftSum + fmax(dp[i][k], dp[k + 1][j]));
                }
            }
        }
    }

    int result = dp[0][stoneValueSize - 1];

    for (int i = 0; i < stoneValueSize; i++) {
        free(dp[i]);
    }
    free(dp);
    free(prefixSum);

    return result;
}