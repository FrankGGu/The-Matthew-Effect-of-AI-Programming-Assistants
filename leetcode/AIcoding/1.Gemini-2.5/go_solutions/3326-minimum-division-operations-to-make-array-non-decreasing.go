package main

func minimumOperations(nums []int) int {
	n := len(nums)
	if n <= 1 {
		return 0
	}

	operations := 0
	// prevVal stores the effective value of nums[i+1] after potential operations.
	// This is the maximum allowed value for nums[i] to maintain non-decreasing order.
	prevVal := nums[n-1]

	// Iterate from the second to last element backwards to the first element.
	for i := n - 2; i >= 0; i-- {
		if nums[i] > prevVal {
			// If nums[i] is greater than the allowed maximum (prevVal),
			// we must perform a division operation on nums[i].
			operations++

			// To minimize operations, we want to make nums[i] as large as possible
			// while satisfying nums[i] / k <= prevVal.
			// This means we need the smallest integer k such that nums[i] / k <= prevVal.
			// The smallest such k is ceil(nums[i] / prevVal).
			// Using integer division, ceil(a/b) can be calculated as (a + b - 1) / b.
			k := (nums[i] + prevVal - 1) / prevVal

			// The new effective value of nums[i] becomes nums[i] / k.
			// This new value then becomes the 'prevVal' for the next iteration (i-1).
			prevVal = nums[i] / k
		} else {
			// If nums[i] is already less than or equal to prevVal,
			// no operation is needed on nums[i] for this pair.
			// The effective value of nums[i] remains its original value,
			// which becomes the 'prevVal' for the next iteration (i-1).
			prevVal = nums[i]
		}
	}

	return operations
}