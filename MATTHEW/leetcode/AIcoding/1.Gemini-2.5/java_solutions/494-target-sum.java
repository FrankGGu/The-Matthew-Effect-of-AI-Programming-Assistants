class Solution {
    public int findTargetSumWays(int[] nums, int target) {
        int sum = 0;
        for (int num : nums) {
            sum += num;
        }

        // The problem can be transformed into a subset sum problem.
        // Let P be the set of numbers with a '+' sign and N be the set of numbers with a '-' sign.
        // We want to find sum(P) - sum(N) = target.
        // We also know sum(P) + sum(N) = sum (total sum of all numbers).
        // Adding these two equations:
        // 2 * sum(P) = target + sum
        // sum(P) = (target + sum) / 2
        //
        // So, we need to find the number of subsets of 'nums' that sum up to (target + sum) / 2.
        // Let s2 = (target + sum) / 2.
        //
        // Constraints for a valid s2:
        // 1. (target + sum) must be non-negative. If target + sum < 0, it's impossible.
        // 2. (target + sum) must be an even number. If it's odd, s2 won't be an integer, so it's impossible.
        //    This is equivalent to checking if (target + sum) % 2 != 0.
        //
        // If these conditions are not met, there are no ways to achieve the target sum.
        if ((target + sum) % 2 != 0 || (target + sum) < 0) {
            return 0;
        }

        int s2 = (target + sum) / 2;

        // dp[i] represents the number of ways to achieve a sum of 'i'.
        int[] dp = new int[s2 + 1];

        // Base case: There is one way to achieve a sum of 0 (by choosing no elements).
        dp[0] = 1;

        // Iterate through each number in nums.
        for (int num : nums) {
            // For each number, update the dp array.
            // Iterate backwards to ensure each number is used at most once for forming a sum.
            for (int j = s2; j >= num; j--) {
                dp[j] += dp[j - num];
            }
        }

        // The result is the number of ways to achieve the target sum s2.
        return dp[s2];
    }
}