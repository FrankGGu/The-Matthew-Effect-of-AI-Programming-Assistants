#include <stdlib.h> // Required for malloc and free

int combinationSum4(int* nums, int numsSize, int target) {
    // dp[i] will store the number of combinations that sum up to i
    int* dp = (int*)malloc((target + 1) * sizeof(int));

    // Initialize dp array with 0s
    for (int i = 0; i <= target; i++) {
        dp[i] = 0;
    }

    // Base case: There is one way to make a sum of 0 (by choosing no numbers)
    dp[0] = 1;

    // Fill the dp array
    // Iterate through all possible sums from 1 to target
    for (int i = 1; i <= target; i++) {
        // For each sum i, iterate through all numbers in nums
        for (int j = 0; j < numsSize; j++) {
            // If the current number can be used to form sum i
            if (i - nums[j] >= 0) {
                // Add the number of combinations for the remaining sum (i - nums[j])
                // Ensure no overflow if dp[i - nums[j]] is very large, though for this problem's constraints,
                // the sum usually fits within a signed 32-bit integer.
                dp[i] += dp[i - nums[j]];
            }
        }
    }

    // The result is stored in dp[target]
    int result = dp[target];

    // Free the allocated memory
    free(dp);

    return result;
}