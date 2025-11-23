#include <stdio.h>
#include <stdlib.h>
#include <string.h>

int rob(int* nums, int numsSize) {
    if (numsSize == 0) return 0;
    if (numsSize == 1) return nums[0];
    if (numsSize == 2) return (nums[0] > nums[1]) ? nums[0] : nums[1];

    int dp[numsSize];
    dp[0] = nums[0];
    dp[1] = (nums[0] > nums[1]) ? nums[0] : nums[1];

    for (int i = 2; i < numsSize; i++) {
        dp[i] = (dp[i - 2] + nums[i] > dp[i - 1]) ? dp[i - 2] + nums[i] : dp[i - 1];
    }

    return dp[numsSize - 1];
}