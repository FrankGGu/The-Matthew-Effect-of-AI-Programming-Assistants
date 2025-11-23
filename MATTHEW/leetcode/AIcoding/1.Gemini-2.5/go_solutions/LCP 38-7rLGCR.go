package main

import "math"

func findMaximumNumberofKGuardedItems(nums []int, k int) int {
	n := len(nums)
	if n == 0 {
		return 0
	}

	dp := make([]int, n)

	// Helper function to get dp value, returning 0 for out-of-bounds negative indices.
	// This effectively handles the base case where no previous items can be selected.
	getDPValue := func(idx int) int {
		if idx < 0 {
			return 0
		}
		return dp[idx]
	}

	// Base case: For the first item, the maximum sum is its own value.
	dp[0] = nums[0]

	for i := 1; i < n; i++ {
		// Option 1: Do not select item at current index i.
		// The maximum sum up to index i is the same as the maximum sum up to index i-1.
		val1 := dp[i-1]

		// Option 2: Select item at current index i.
		// If we select nums[i], then any previously selected item nums[j] (where j < i)
		// must satisfy the condition: abs(i - j) > k.
		// Since j < i, this simplifies to i - j > k, which means j < i - k.
		// The largest possible index for a compatible previous item is j = i - k - 1.
		// So, we add nums[i] to the maximum sum obtained from items up to index (i - k - 1).
		val2 := nums[i]
		prevDPIdx := i - k - 1
		val2 += getDPValue(prevDPIdx)

		// The maximum sum up to index i is the maximum of these two options.
		dp[i] = int(math.Max(float64(val1), float64(val2)))
	}

	// The problem asks to maximize the sum. If all item values are negative,
	// choosing an empty set (sum 0) might be the optimal solution.
	// So, the final result should be at least 0.
	return int(math.Max(0.0, float64(dp[n-1])))
}