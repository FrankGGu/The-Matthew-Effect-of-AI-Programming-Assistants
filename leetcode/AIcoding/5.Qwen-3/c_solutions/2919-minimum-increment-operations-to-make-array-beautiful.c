#include <stdio.h>
#include <stdlib.h>

int minIncrementOperations(int* nums, int numsSize, int k) {
    int* dp = (int*)malloc(numsSize * sizeof(int));
    for (int i = 0; i < numsSize; i++) {
        dp[i] = 0;
    }

    for (int i = 3; i < numsSize; i++) {
        dp[i] = dp[i - 3] + (k - nums[i]) > 0 ? (k - nums[i]) : 0;
    }

    int result = dp[numsSize - 1];
    free(dp);
    return result;
}