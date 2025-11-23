#include <stdio.h>
#include <stdlib.h>
#include <string.h>

bool isValidPartition(int* nums, int numsSize) {
    bool dp[numsSize + 1];
    for (int i = 0; i <= numsSize; i++) {
        dp[i] = false;
    }
    dp[0] = true;

    for (int i = 2; i <= numsSize; i++) {
        if (nums[i - 1] == nums[i - 2]) {
            dp[i] = dp[i] || dp[i - 2];
        }
        if (i > 2 && nums[i - 1] == nums[i - 2] && nums[i - 2] == nums[i - 3]) {
            dp[i] = dp[i] || dp[i - 3];
        }
        if (i > 2 && nums[i - 1] == nums[i - 2] + 1 && nums[i - 2] == nums[i - 3] + 2) {
            dp[i] = dp[i] || dp[i - 3];
        }
    }

    return dp[numsSize];
}