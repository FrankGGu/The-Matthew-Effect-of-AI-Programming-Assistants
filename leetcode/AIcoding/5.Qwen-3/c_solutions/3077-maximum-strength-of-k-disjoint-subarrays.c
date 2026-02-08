#include <stdio.h>
#include <stdlib.h>
#include <limits.h>

int maxStrength(int* nums, int numsSize, int k) {
    int** dp = (int**)malloc(sizeof(int*) * (k + 1));
    for (int i = 0; i <= k; i++) {
        dp[i] = (int*)malloc(sizeof(int) * numsSize);
        for (int j = 0; j < numsSize; j++) {
            dp[i][j] = INT_MIN;
        }
    }

    for (int i = 0; i < numsSize; i++) {
        dp[1][i] = nums[i];
        if (i > 0) {
            dp[1][i] = fmax(dp[1][i], dp[1][i - 1]);
        }
    }

    for (int t = 2; t <= k; t++) {
        for (int i = t - 1; i < numsSize; i++) {
            for (int j = t - 2; j < i; j++) {
                dp[t][i] = fmax(dp[t][i], dp[t - 1][j] + nums[i]);
            }
        }
    }

    int result = INT_MIN;
    for (int i = k - 1; i < numsSize; i++) {
        result = fmax(result, dp[k][i]);
    }

    for (int i = 0; i <= k; i++) {
        free(dp[i]);
    }
    free(dp);

    return result;
}