#include <stdbool.h>
#include <stdlib.h>

bool canPartition(int* nums, int numsSize) {
    int totalSum = 0;
    for (int i = 0; i < numsSize; i++) {
        totalSum += nums[i];
    }

    if (totalSum % 2 != 0) {
        return false;
    }

    int target = totalSum / 2;

    bool* dp = (bool*)calloc(target + 1, sizeof(bool));
    if (dp == NULL) {
        return false; 
    }

    dp[0] = true;

    for (int i = 0; i < numsSize; i++) {
        int num = nums[i];
        for (int s = target; s >= num; s--) {
            dp[s] = dp[s] || dp[s - num];
        }
    }

    bool result = dp[target];
    free(dp);
    return result;
}