#include <stdio.h>
#include <stdlib.h>

int combinationSum4(int* nums, int numsSize, int target) {
    int* dp = (int*)malloc((target + 1) * sizeof(int));
    dp[0] = 1;
    for (int i = 1; i <= target; i++) {
        dp[i] = 0;
        for (int j = 0; j < numsSize; j++) {
            if (i >= nums[j]) {
                dp[i] += dp[i - nums[j]];
            }
        }
    }
    int result = dp[target];
    free(dp);
    return result;
}