#include <stdio.h>
#include <stdlib.h>

int findTargetSumWays(int* nums, int numsSize, int target) {
    int sum = 0;
    for (int i = 0; i < numsSize; i++) {
        sum += nums[i];
    }
    if (target > sum || target < -sum) return 0;
    int* dp = (int*)calloc(sum * 2 + 1, sizeof(int));
    dp[0 + sum] = 1;
    for (int i = 0; i < numsSize; i++) {
        int* new_dp = (int*)calloc(sum * 2 + 1, sizeof(int));
        for (int j = 0; j < sum * 2 + 1; j++) {
            if (dp[j] > 0) {
                new_dp[j + nums[i]] += dp[j];
                new_dp[j - nums[i]] += dp[j];
            }
        }
        free(dp);
        dp = new_dp;
    }
    return dp[target + sum];
}