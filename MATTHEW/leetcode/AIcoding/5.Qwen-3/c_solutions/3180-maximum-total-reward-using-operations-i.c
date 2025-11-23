#include <stdio.h>
#include <stdlib.h>

int maximumTotalReward(int* nums, int numsSize) {
    int maxNum = 0;
    for (int i = 0; i < numsSize; ++i) {
        if (nums[i] > maxNum) {
            maxNum = nums[i];
        }
    }

    int* dp = (int*)calloc(maxNum + 1, sizeof(int));
    for (int i = 0; i < numsSize; ++i) {
        int num = nums[i];
        if (num > 0) {
            for (int j = maxNum; j >= num; --j) {
                if (dp[j - num] + num > dp[j]) {
                    dp[j] = dp[j - num] + num;
                }
            }
        }
    }

    int result = 0;
    for (int i = 0; i <= maxNum; ++i) {
        if (dp[i] > result) {
            result = dp[i];
        }
    }

    free(dp);
    return result;
}