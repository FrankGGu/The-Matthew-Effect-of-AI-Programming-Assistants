package main

import (
	"math"
)

func maxAlternatingSum(nums []int) int64 {
	// add: maximum alternating sum ending with a positive number.
	//      This state tracks the maximum sum of a subsequence where the last chosen element is added.
	// sub: maximum alternating sum ending with a negative number.
	//      This state tracks the maximum sum of a subsequence where the last chosen element is subtracted.

	// Initialize 'add' to 0. This allows for an empty subsequence (sum 0),
	// or for any 'num' to be the first positive term of a new subsequence.
	// Initialize 'sub' to math.MinInt64. An alternating subsequence cannot logically start with a negative term,
	// and we haven't picked any positive term yet to subtract from.
	var add int64 = 0
	var sub int64 = math.MinInt64

	for _, num := range nums {
		n := int64(num)

		// Store current 'add' and 'sub' values before they are updated for the current 'num'.
		// These 'prevAdd' and 'prevSub' are used to calculate the new states based on previous results.
		prevAdd := add
		prevSub := sub

		// Calculate the new 'add' state:
		// This represents the maximum alternating sum ending with '+n'.
		// There are three ways to achieve this:
		// 1. Don't include 'n' in the current subsequence. The max sum remains 'prevAdd'.
		// 2. Start a new subsequence with 'n'. The sum is simply 'n'.
		// 3. Extend a subsequence that ended with a negative term (prevSub) by adding 'n'. The sum is 'prevSub + n'.
		// We take the maximum of these options.
		add = max(prevAdd, n)
		if prevSub != math.MinInt64 { // Only consider extending if prevSub is a valid sum
			add = max(add, prevSub+n)
		}

		// Calculate the new 'sub' state:
		// This represents the maximum alternating sum ending with '-n'.
		// There are two ways to achieve this:
		// 1. Don't include 'n' in the current subsequence. The max sum remains 'prevSub'.
		// 2. Extend a subsequence that ended with a positive term (prevAdd) by subtracting 'n'. The sum is 'prevAdd - n'.
		// We take the maximum of these options.
		sub = max(prevSub, prevAdd-n)
	}

	// The maximum alternating sum will always be an 'add' state.
	// This is because if the maximum sum ended with a negative term (e.g., A - B + C - D),
	// then removing the last negative term (A - B + C) would result in a sum
	// that is greater than or equal to the original sum (since nums[i] >= 1, removing -D makes it larger).
	// Thus, the global maximum must be one of the 'add' states.
	return add
}

func max(a, b int64) int64 {
	if a > b {
		return a
	}
	return b
}