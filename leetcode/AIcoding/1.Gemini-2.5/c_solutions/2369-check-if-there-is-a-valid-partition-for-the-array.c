#include <stdbool.h>
#include <stdlib.h>

bool validPartition(int* nums, int numsSize) {
    if (numsSize < 2) {
        return false;
    }

    bool* dp = (bool*)malloc(sizeof(bool) * (numsSize + 1));

    dp[0] = true; 

    for (int i = 1; i <= numsSize; ++i) {
        dp[i] = false; 

        // Check for a valid partition of length 2 ending at nums[i-1]
        // This means nums[i-2] and nums[i-1] form a pair.
        // Requires i >= 2
        if (i >= 2) {
            if (nums[i-2] == nums[i-1]) {
                dp[i] = dp[i] || dp[i-2];
            }
        }

        // Check for a valid partition of length 3 ending at nums[i-1]
        // This means nums[i-3], nums[i-2], nums[i-1] form a triplet.
        // Requires i >= 3
        if (i >= 3) {
            // Condition 1: Three equal elements
            if (nums[i-3] == nums[i-2] && nums[i-2] == nums[i-1]) {
                dp[i] = dp[i] || dp[i-3];
            }
            // Condition 2: Three consecutive increasing elements
            if (nums[i-3] + 1 == nums[i-2] && nums[i-2] + 1 == nums[i-1]) {
                dp[i] = dp[i] || dp[i-3];
            }
        }
    }

    bool result = dp[numsSize];
    free(dp); 
    return result;
}