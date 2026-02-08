#include <stdio.h>
#include <stdlib.h>
#include <stdbool.h>

bool canPartition(int* nums, int numsSize) {
    int total = 0;
    for (int i = 0; i < numsSize; i++) {
        total += nums[i];
    }
    if (total % 2 != 0) return false;
    int target = total / 2;
    bool* dp = (bool*)calloc(target + 1, sizeof(bool));
    dp[0] = true;
    for (int i = 0; i < numsSize; i++) {
        for (int j = target; j >= nums[i]; j--) {
            if (dp[j - nums[i]]) {
                dp[j] = true;
            }
        }
    }
    return dp[target];
}