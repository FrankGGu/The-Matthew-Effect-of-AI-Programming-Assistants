#include <stdio.h>
#include <stdlib.h>

int lengthOfLIS(int* nums, int numsSize) {
    int max_val = 0;
    for (int i = 0; i < numsSize; ++i) {
        if (nums[i] > max_val) {
            max_val = nums[i];
        }
    }

    int* dp = (int*)calloc(max_val + 1, sizeof(int));
    for (int i = 0; i < numsSize; ++i) {
        int max_len = 0;
        for (int j = 1; j < nums[i]; ++j) {
            if (dp[j] > max_len) {
                max_len = dp[j];
            }
        }
        dp[nums[i]] = max_len + 1;
    }

    int result = 0;
    for (int i = 0; i <= max_val; ++i) {
        if (dp[i] > result) {
            result = dp[i];
        }
    }

    free(dp);
    return result;
}