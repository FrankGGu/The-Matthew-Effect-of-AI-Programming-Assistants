func zeroFilledSubarrays(nums []int) int64 {
	var totalSubarrays int64 = 0
	var currentZeroCount int64 = 0

	for _, num := range nums {
		if num == 0 {
			currentZeroCount++
		} else {
			// If we encountered a sequence of zeros, add their contribution
			// The number of subarrays for a sequence of k zeros is k * (k + 1) / 2
			if currentZeroCount > 0 {
				totalSubarrays += currentZeroCount * (currentZeroCount + 1) / 2
			}
			// Reset count for non-zero elements
			currentZeroCount = 0
		}
	}

	// After the loop, if there's a trailing sequence of zeros, add their contribution
	if currentZeroCount > 0 {
		totalSubarrays += currentZeroCount * (