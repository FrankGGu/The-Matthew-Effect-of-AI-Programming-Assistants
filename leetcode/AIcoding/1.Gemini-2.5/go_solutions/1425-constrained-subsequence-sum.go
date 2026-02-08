package main

import "math"

func constrainedSubsetSum(nums []int, k int) int {
	n := len(nums)
	dp := make([]int, n)

	deque := make([]int, 0) // Stores indices of elements in dp array, maintaining a monotonically decreasing sequence of dp values.

	maxSum := math.MinInt32 // Initialize with the smallest possible integer

	for i := 0; i < n; i++ {
		// Remove elements from the front of the deque if their index is out of the window [i-k, i-1]
		for len(deque) > 0 && deque[0] < i-k {
			deque = deque[1:]
		}

		// Calculate dp[i]
		// currentMaxPrevDP stores the maximum dp value from the valid window [i-k, i-1].
		// If deque is empty, there are no valid previous elements to extend from, so we consider 0.
		currentMaxPrevDP := 0
		if len(deque) > 0 {
			currentMaxPrevDP = dp[deque[0]]
		}

		// dp[i] is nums[i] plus the maximum of 0 (starting a new subsequence)
		// or the maximum previous constrained subsequence sum.
		dp[i] = nums[i] + max(0, currentMaxPrevDP)

		// Update the overall maximum sum found so far
		maxSum = max(maxSum, dp[i])

		// Maintain the deque: remove elements from the back that are less than or equal to dp[i]
		// This ensures the deque remains monotonically decreasing, keeping only potentially optimal previous sums.
		for len(deque) > 0 && dp[deque[len(deque)-1]] <= dp[i] {
			deque = deque[:len(deque)-1]
		}

		// Add current index to the back of the deque
		deque = append(deque, i)
	}

	return maxSum
}

func max(a, b int) int {
	if a > b {
		return a
	}
	return b
}