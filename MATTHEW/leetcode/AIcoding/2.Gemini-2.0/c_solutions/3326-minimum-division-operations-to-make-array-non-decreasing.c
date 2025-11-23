#include <stdio.h>
#include <stdlib.h>
#include <string.h>

int minimumDivisionOperations(int* nums, int numsSize) {
    int dp[numsSize][32];
    for (int i = 0; i < numsSize; i++) {
        for (int j = 0; j < 32; j++) {
            dp[i][j] = INT_MAX;
        }
    }

    for (int i = 0; i < 32; i++) {
        dp[0][i] = i;
    }

    for (int i = 1; i < numsSize; i++) {
        for (int j = 0; j < 32; j++) {
            for (int k = 0; k < 32; k++) {
                if (nums[i - 1] / (1 << k) <= nums[i] / (1 << j)) {
                    if (dp[i - 1][k] != INT_MAX) {
                        dp[i][j] = fmin(dp[i][j], dp[i - 1][k] + j);
                    }
                } else {
                    if (dp[i - 1][k] != INT_MAX) {
                        dp[i][j] = fmin(dp[i][j], dp[i - 1][k] + j + 1);
                    }
                }
            }
        }
    }

    int minOperations = INT_MAX;
    for (int i = 0; i < 32; i++) {
        minOperations = fmin(minOperations, dp[numsSize - 1][i]);
    }

    return minOperations;
}