#include <vector>
#include <numeric> // For std::accumulate, though a manual loop is used

class Solution {
public:
    int findTargetSumWays(std::vector<int>& nums, int target) {
        int sum = 0;
        for (int num : nums) {
            sum += num;
        }

        // We are looking for a partition of nums into two subsets, P and N,
        // such that elements in P are assigned '+' and elements in N are assigned '-'.
        // We want sum(P) - sum(N) = target.
        // We also know sum(P) + sum(N) = sum(nums) (let's call this 'total_sum').
        // Adding the two equations:
        // 2 * sum(P) = target + total_sum
        // sum(P) = (target + total_sum) / 2

        // If (target + sum) is negative, it's impossible for sum(P) to be negative.
        // If (target + sum) is odd, it's impossible for sum(P) to be an integer.
        // In both cases, there are no ways.
        if ((target + sum) < 0 || (target + sum) % 2 != 0) {
            return 0;
        }

        // The problem reduces to finding the number of subsets of 'nums'
        // that sum up to 'target_sum_subset'.
        int target_sum_subset = (target + sum) / 2;

        // dp[i] will store the number of ways to achieve a sum of 'i'.
        // The maximum possible target_sum_subset can be (1000 + 20*1000)/2 = 10500.
        std::vector<int> dp(target_sum_subset + 1, 0);
        dp[0] = 1; // There is one way to achieve a sum of 0 (by choosing no elements).

        // Iterate through each number in nums.
        for (int num : nums) {
            // Iterate backwards from target_sum_subset down to 'num'.
            // This ensures that each number 'num' is used at most once
            // (0/1 knapsack-like problem).
            for (int j = target_sum_subset; j >= num; --j) {
                dp[j] += dp[j - num];
            }
        }

        return dp[target_sum_subset];
    }
};