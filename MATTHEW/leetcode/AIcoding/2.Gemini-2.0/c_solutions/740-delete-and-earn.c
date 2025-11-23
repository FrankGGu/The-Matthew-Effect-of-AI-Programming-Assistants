#include <stdio.h>
#include <stdlib.h>
#include <string.h>

int deleteAndEarn(int* nums, int numsSize) {
    int maxVal = 0;
    for (int i = 0; i < numsSize; i++) {
        if (nums[i] > maxVal) {
            maxVal = nums[i];
        }
    }

    int* values = (int*)malloc((maxVal + 1) * sizeof(int));
    for (int i = 0; i <= maxVal; i++) {
        values[i] = 0;
    }

    for (int i = 0; i < numsSize; i++) {
        values[nums[i]] += nums[i];
    }

    int* dp = (int*)malloc((maxVal + 1) * sizeof(int));
    dp[0] = 0;
    dp[1] = values[1];

    for (int i = 2; i <= maxVal; i++) {
        dp[i] = (dp[i - 1] > (dp[i - 2] + values[i])) ? dp[i - 1] : (dp[i - 2] + values[i]);
    }

    int result = dp[maxVal];
    free(values);
    free(dp);
    return result;
}