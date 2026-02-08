#include <stdlib.h>
#include <string.h>

int findTargetSumWays(int* nums, int numsSize, int target) {
    int total_sum = 0;
    int zero_count = 0;

    for (int i = 0; i < numsSize; i++) {
        total_sum += nums[i];
        if (nums[i] == 0) {
            zero_count++;
        }
    }

    // The problem can be transformed into a subset sum problem.
    // Let P be the sum of numbers with a '+' sign and N be the sum of numbers with a '-' sign.
    // We want to find the number of ways such that P - N = target.
    // We also know that P + N = total_sum (sum of all numbers in nums).
    // Adding the two equations: 2P = target + total_sum.
    // So, P = (target + total_sum) / 2.
    // This means we need to find the number of subsets of nums that sum up to P.

    // If (target + total_sum) is negative or odd, it's impossible to find an integer P.
    // In this case, there are 0 ways.
    if ((target + total_sum) % 2 != 0 || (target + total_sum) < 0) {
        return 0;
    }

    int s = (target + total_sum) / 2;

    // dp[i] will store the number of ways to achieve sum i.
    // The maximum possible value for s is (20 * 1000 + 1000) / 2 = 10500.
    // So, an array of size s + 1 is feasible.
    int* dp = (int*)calloc(s + 1, sizeof(int));
    if (dp == NULL) {
        return 0; // Allocation failed
    }

    dp[0] = 1; // There is one way to achieve a sum of 0 (by choosing no elements).

    // Iterate through each number in nums.
    // Zeros are handled separately because +0 and -0 both contribute to the sum,
    // but a 0 in the DP calculation would incorrectly double dp[j] if j-0 is used.
    for (int i = 0; i < numsSize; i++) {
        if (nums[i] == 0) {
            continue; // Skip zeros for the DP calculation
        }
        // Iterate downwards to ensure each number is used at most once for a given sum.
        for (int j = s; j >= nums[i]; j--) {
            dp[j] += dp[j - nums[i]];
        }
    }

    int result = dp[s];
    free(dp);

    // Each zero in the original nums array can be assigned either a '+' or '-' sign.
    // For 'k' zeros, there are 2^k ways to assign signs to them without changing the final sum.
    // So, the total number of ways is multiplied by 2^zero_count.
    return result * (1 << zero_count);
}