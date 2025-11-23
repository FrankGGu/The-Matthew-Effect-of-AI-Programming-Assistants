#include <stdlib.h> // For calloc, free

int findTargetSumWays(int* nums, int numsSize, int target) {
    int sum = 0;
    for (int i = 0; i < numsSize; i++) {
        sum += nums[i];
    }

    // The problem can be rephrased as finding a subset of nums, P,
    // such that sum(P) - sum(N) = target, where N is the remaining numbers.
    // We know sum(P) + sum(N) = sum(nums).
    // Adding the two equations: 2 * sum(P) = target + sum(nums).
    // So, sum(P) = (target + sum(nums)) / 2.
    // This means (target + sum(nums)) must be non-negative and even.
    if ((target + sum) < 0 || (target + sum) % 2 != 0) {
        return 0;
    }

    int subsetSumTarget = (target + sum) / 2;

    // dp[i] will store the number of ways to achieve a sum of i
    // The maximum possible value for subsetSumTarget is when all nums are 1000 and numsSize is 20,
    // and target is 1000. sum = 20000. (1000 + 20000) / 2 = 10500.
    // An array of size ~10501 is feasible.
    int* dp = (int*)calloc(subsetSumTarget + 1, sizeof(int));
    if (dp == NULL) {
        // Memory allocation failed
        return 0; 
    }

    // There is one way to achieve a sum of 0 (by taking no elements)
    dp[0] = 1;

    // Iterate through each number in nums
    for (int i = 0; i < numsSize; i++) {
        // Iterate backwards from subsetSumTarget down to the current number
        // This ensures that each number is used at most once for forming a sum
        for (int j = subsetSumTarget; j >= nums[i]; j--) {
            dp[j] += dp[j - nums[i]];
        }
    }

    int result = dp[subsetSumTarget];
    free(dp); // Free the dynamically allocated memory
    return result;
}