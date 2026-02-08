class Solution {
    public int findTargetSumWays(int[] nums, int target) {
        int sum = 0;
        for (int num : nums) {
            sum += num;
        }

        // The problem can be transformed into finding a subset P such that
        // sum(P) - sum(N) = target
        // sum(P) + sum(N) = sum (total sum of all numbers)
        // Adding these two equations:
        // 2 * sum(P) = target + sum
        // sum(P) = (target + sum) / 2

        // If (target + sum) is negative or odd, it's impossible to find such a subset P.
        if (target + sum < 0 || (target + sum) % 2 != 0) {
            return 0;
        }

        int sP = (target + sum) / 2;

        // Now, the problem is to find the number of subsets in nums that sum up to sP.
        // This is a classic subset sum problem using dynamic programming.
        // dp[i] will store the number of ways to achieve a sum of i.
        int[] dp = new int[sP + 1];

        // Base case: There is one way to achieve a sum of 0 (by choosing no numbers).
        dp[0] = 1;

        // Iterate through each number in nums
        for (int num : nums) {
            // Iterate from sP down to num
            // This ensures that each number is used at most once for the current dp calculation
            // (i.e., we don't use dp[j - num] which might have already included the current num)
            for (int j = sP; j >= num; j--) {
                dp[j] += dp[j - num];
            }
        }

        return dp[sP];
    }
}