func checkSubarraySum(nums []int, k int) bool {
	// Use a map to store remainder -> index of its first occurrence.
	// We initialize it with (0, -1) to handle cases where the subarray
	// itself starts from index 0 and its sum is a multiple of k.
	remainderMap := make(map[int]int)
	remainderMap[0] = -1 // remainder 0 is considered to be found before index 0

	currentSum := 0
	for i := 0; i < len(nums); i++ {
		currentSum += nums[i]

		var remainder int
		if k == 0 {
			// If k is 0, we are looking for a subarray that sums to 0.
			// In this case, the 'remainder' is the sum itself.
			remainder = currentSum
		} else {
			remainder = currentSum % k
		}

		if prevIndex, found := remainderMap[remainder]; found {
			// If this remainder has been seen before, it means there's a subarray
			// between prevIndex+1 and i whose sum is a multiple of k (or 0 if k=0).
			// We need to ensure the length of this subarray is at least 2.
			if i-prevIndex >= 2 {
				return true
			}
		} else {
			// Store the first occurrence of this remainder.
			// We only store the first occurrence to maximize the length (i - prevIndex).
			remainderMap[remainder] = i
		}
	}

	return false
}