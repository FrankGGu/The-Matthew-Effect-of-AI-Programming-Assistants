#include <stdio.h>
#include <stdlib.h>

int maximumScore(int* nums, int numsSize, int* multipliers, int multipliersSize) {
    int** dp = (int**)malloc((multipliersSize + 1) * sizeof(int*));
    for (int i = 0; i <= multipliersSize; i++) {
        dp[i] = (int*)malloc((multipliersSize + 1) * sizeof(int));
    }

    for (int i = 0; i <= multipliersSize; i++) {
        for (int j = 0; j <= multipliersSize; j++) {
            dp[i][j] = 0;
        }
    }

    for (int i = 1; i <= multipliersSize; i++) {
        for (int j = 0; j <= i; j++) {
            int k = i - j;
            if (j == 0) {
                dp[i][j] = dp[i - 1][j] + nums[k] * multipliers[i - 1];
            } else if (k == 0) {
                dp[i][j] = dp[i - 1][j - 1] + nums[j - 1] * multipliers[i - 1];
            } else {
                dp[i][j] = fmax(dp[i - 1][j - 1] + nums[j - 1] * multipliers[i - 1], dp[i - 1][j] + nums[k] * multipliers[i - 1]);
            }
        }
    }

    int result = 0;
    for (int i = 0; i <= multipliersSize; i++) {
        result = fmax(result, dp[multipliersSize][i]);
    }

    for (int i = 0; i <= multipliersSize; i++) {
        free(dp[i]);
    }
    free(dp);

    return result;
}