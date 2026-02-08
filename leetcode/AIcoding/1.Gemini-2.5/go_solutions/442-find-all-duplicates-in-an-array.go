package main

func findDuplicates(nums []int) []int {
	result := []int{}
	for i := 0; i < len(nums); i++ {
		// Get the absolute value of the current number to use as an index.
		// If nums[i] is already negative, it means its original positive value
		// was used to mark an index. We need that original positive value.
		val := nums[i]
		if val < 0 {
			val = -val
		}

		// The numbers are in the range [1, n], so the corresponding 0-indexed position is val - 1.
		idx := val - 1

		// If nums[idx] is negative, it means we have encountered 'val' before,
		// so 'val' is a duplicate.
		if nums[idx] < 0 {
			result = append(result, val)
		} else {
			// If nums[idx] is positive, it means 'val' is encountered for the first time.
			// Mark it as seen by making the element at nums[idx] negative.
			nums[idx] = -nums[idx]
		}
	}
	return result
}