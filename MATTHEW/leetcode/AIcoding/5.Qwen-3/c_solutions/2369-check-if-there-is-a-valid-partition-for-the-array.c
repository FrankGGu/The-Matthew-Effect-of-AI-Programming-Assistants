#include <stdio.h>
#include <stdlib.h>
#include <stdbool.h>

bool validPartition(int* nums, int numsSize) {
    if (numsSize < 3) return false;

    bool* dp = (bool*)malloc(numsSize * sizeof(bool));
    for (int i = 0; i < numsSize; i++) {
        dp[i] = false;
    }

    if (numsSize >= 3) {
        if (nums[0] == nums[1] && nums[1] == nums[2]) {
            dp[2] = true;
        } else if (nums[0] == nums[1] && nums[1] + 1 == nums[2]) {
            dp[2] = true;
        } else if (nums[0] + 1 == nums[1] && nums[1] + 1 == nums[2]) {
            dp[2] = true;
        }
    }

    for (int i = 3; i < numsSize; i++) {
        if (dp[i - 3] && nums[i] == nums[i - 1] && nums[i - 1] == nums[i - 2]) {
            dp[i] = true;
        } else if (dp[i - 3] && nums[i] == nums[i - 1] && nums[i - 1] + 1 == nums[i - 2]) {
            dp[i] = true;
        } else if (dp[i - 3] && nums[i] - 1 == nums[i - 1] && nums[i - 1] - 1 == nums[i - 2]) {
            dp[i] = true;
        } else if (dp[i - 2] && nums[i] == nums[i - 1] && nums[i - 1] == nums[i - 2]) {
            dp[i] = true;
        } else if (dp[i - 2] && nums[i] == nums[i - 1] && nums[i - 1] + 1 == nums[i - 2]) {
            dp[i] = true;
        } else if (dp[i - 2] && nums[i] - 1 == nums[i - 1] && nums[i - 1] - 1 == nums[i - 2]) {
            dp[i] = true;
        } else if (dp[i - 1] && nums[i] == nums[i - 1] && nums[i - 1] == nums[i - 2]) {
            dp[i] = true;
        } else if (dp[i - 1] && nums[i] == nums[i - 1] && nums[i - 1] + 1 == nums[i - 2]) {
            dp[i] = true;
        } else if (dp[i - 1] && nums[i] - 1 == nums[i - 1] && nums[i - 1] - 1 == nums[i - 2]) {
            dp[i] = true;
        }
    }

    bool result = dp[numsSize - 1];
    free(dp);
    return result;
}