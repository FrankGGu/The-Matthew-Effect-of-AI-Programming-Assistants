#include <stdlib.h>
#include <string.h>

int max(int a, int b) {
    return a > b ? a : b;
}

int stoneGameV(int* stones, int stonesSize) {
    if (stonesSize <= 1) {
        return 0;
    }

    int* prefixSum = (int*)malloc((stonesSize + 1) * sizeof(int));
    prefixSum[0] = 0;
    for (int i = 0; i < stonesSize; ++i) {
        prefixSum[i+1] = prefixSum[i] + stones[i];
    }

    int** dp = (int**)malloc(stonesSize * sizeof(int*));
    for (int i = 0; i < stonesSize; ++i) {
        dp[i] = (int*)malloc(stonesSize * sizeof(int));
        memset(dp[i], 0, stonesSize * sizeof(int));
    }

    for (int len = 2; len <= stonesSize; ++len) {
        for (int i = 0; i <= stonesSize - len; ++i) {
            int j = i + len - 1;

            for (int k = i; k < j; ++k) {
                int sumL = prefixSum[k+1] - prefixSum[i];
                int sumR = prefixSum[j+1] - prefixSum[k+1];

                int current_score;
                if (sumL == sumR) {
                    current_score = sumL + max(dp[i][k], dp[k+1][j]);
                } else if (sumL < sumR) {
                    current_score = sumL + dp[i][k];
                } else { // sumL > sumR
                    current_score = sumR + dp[k+1][j];
                }

                dp[i][j] = max(dp[i][j], current_score);
            }
        }
    }

    int result = dp[0][stonesSize - 1];

    free(prefixSum);
    for (int i = 0; i < stonesSize; ++i) {
        free(dp[i]);
    }
    free(dp);

    return result;
}