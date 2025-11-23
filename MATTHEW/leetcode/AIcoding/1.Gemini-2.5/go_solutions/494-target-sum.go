func findTargetSumWays(nums []int, target int) int {
	totalSum := 0
	for _, num := range nums {
		totalSum += num
	}

	// The problem can be transformed into a subset sum problem.
	// Let P be the sum of numbers chosen with a '+' sign, and N be the sum of numbers chosen with a '-' sign.
	// We want P - N = target.
	// Also, P + N = totalSum (sum of all numbers in nums).
	// Adding the two equations: 2P = target + totalSum
	// So, P = (target + totalSum) / 2.

	// For P to be a valid sum of a subset of non-negative integers:
	// 1. (target + totalSum) must be non-negative. If it's negative, P would be negative, which is impossible.
	// 2. (target + totalSum) must be even. If it's odd, P would not be an integer, which is impossible.
	if (totalSum+target)%2 != 0 || (totalSum+target) < 0 {
		return 0
	}

	// s is the target sum for the subset sum problem.
	s := (totalSum + target) / 2

	// dp[i] will store the number of ways to achieve sum i using numbers from nums.
	// The maximum possible value for s is totalSum, which can be up to 20 * 1000 = 20000.
	dp := make([]int, s+1)

	// Base case: There is one way to achieve sum 0 (by choosing no numbers).
	dp[0] = 1

	// Iterate through each number in nums.
	for _, num := range nums {
		// Iterate backwards from s down to num.
		// This ensures that each number is used at most once for a given sum calculation.
		// If we iterate forwards, dp[j-num] would already reflect the current num being included,
		// effectively allowing multiple uses of the same num in the current iteration.
		for j := s; j >= num; j-- {
			dp[j] += dp[j-num]
		}
	}

	// The result is the number of ways to achieve the sum 's'.
	return dp[s]
}