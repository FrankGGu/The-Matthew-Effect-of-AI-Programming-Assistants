package main

import "math"

func maximizeTotalCost(nums []int) int64 {
	n := len(nums)
	if n == 0 {
		return 0
	}

	// prevPos represents the maximum total cost ending at the previous index,
	// where the element at the previous index was added positively.
	// prevNeg represents the maximum total cost ending at the previous index,
	// where the element at the previous index was added negatively.
	prevPos := int64(nums[0])
	prevNeg := int64(math.MinInt64 / 2) // Initialize with a very small number to represent negative infinity

	for i := 1; i < n; i++ {
		currentNum := int64(nums[i])

		// Calculate currPos: maximum total cost ending at current index i,
		// where nums[i] is added positively.
		// This can happen in two ways:
		// 1. nums[i] starts a new subarray. The total cost up to i-1 is max(prevPos, prevNeg).
		//    Then add currentNum.
		// 2. nums[i] extends a subarray where nums[i-1] was added negatively.
		//    This means prevNeg + currentNum.
		// Combining these, it's max(prevPos, prevNeg) + currentNum.
		currPos := max(prevPos, prevNeg) + currentNum

		// Calculate currNeg: maximum total cost ending at current index i,
		// where nums[i] is added negatively.
		// This can only happen if nums[i] extends a subarray where nums[i-1] was added positively.
		currNeg := prevPos - currentNum

		// Update prev values for the next iteration
		prevPos = currPos
		prevNeg = currNeg
	}

	// The final answer is the maximum of the costs ending with a positive or negative term
	// at the last index.
	return max(prevPos, prevNeg)
}

func max(a, b int64) int64 {
	if a > b {
		return a
	}
	return b
}