#include <stdio.h>
#include <stdlib.h>

int splitArray(int* nums, int numsSize, int m) {
    int* dp = (int*)malloc(sizeof(int) * numsSize);
    int* prefix = (int*)malloc(sizeof(int) * (numsSize + 1));

    for (int i = 0; i < numsSize; ++i) {
        prefix[i + 1] = prefix[i] + nums[i];
    }

    for (int i = 0; i < numsSize; ++i) {
        dp[i] = prefix[numsSize] - prefix[i];
    }

    for (int i = 1; i < m; ++i) {
        int* new_dp = (int*)malloc(sizeof(int) * numsSize);
        for (int j = 0; j < numsSize; ++j) {
            new_dp[j] = INT_MAX;
            for (int k = j; k < numsSize; ++k) {
                if (dp[k] + (prefix[k + 1] - prefix[j]) < new_dp[j]) {
                    new_dp[j] = dp[k] + (prefix[k + 1] - prefix[j]);
                }
            }
        }
        free(dp);
        dp = new_dp;
    }

    int result = dp[0];
    free(dp);
    free(prefix);
    return result;
}