func sumCounts(nums []int) int {
	totalSum := 0
	n := len(nums)

	// Iterate through all possible starting indices of subarrays
	for i := 0; i < n; i++ {
		// Create a map to store distinct elements for the current subarray
		// starting at 'i'. This map is reset for each new starting index 'i'.
		distinctElements := make(map[int]bool)

		// Iterate through all possible ending indices of subarrays,
		// starting from the current 'i' up to the end of the array.
		// This loop extends the current subarray nums[i...j].
		for j := i; j < n; j++ {
			// Add the current element nums[j] to the set of distinct elements.
			distinctElements[nums[j]] = true

			// The count of distinct elements for the current subarray nums[i...j]
			// is simply the