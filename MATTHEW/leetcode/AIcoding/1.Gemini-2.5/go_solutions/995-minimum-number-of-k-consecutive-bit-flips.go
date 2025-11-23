func minKBitFlips(nums []int, k int) int {
	n := len(nums)
	ans := 0
	currentFlips := 0 // Tracks the number of active flips affecting the current position i

	// Iterate through the array
	for i := 0; i < n; i++ {
		// If a flip started at index i-k, its effect ends at index i-1.
		// So, at index i, this flip is no longer active.
		// We marked a flip starting at index j by setting nums[j] to 2.
		if i >= k && nums[i-k] == 2 {
			currentFlips--
		}

		// Calculate the effective value of nums[i].
		// The effective value is nums[i] XORed with the number of active flips.
		// If currentFlips is odd, it means nums[i] is effectively flipped.
		effectiveVal := nums[i]
		if currentFlips%2 == 1 {
			effectiveVal = 1 - effectiveVal
		}

		// If the effective value is 0, we need to perform a flip starting at i.
		if effectiveVal == 0 {
			ans++
			// Check if we can perform a flip of k bits starting at i.
			// If i+k is beyond the array bounds, it's impossible to perform a k-bit flip.
			if i+k > n {
				return -1
			}
			// Mark that a flip started at index i.
			// This flip will affect positions from i to i+k-1.
			// We use nums[i] = 2 to mark this, as original values are 0 or 1.
			nums[i] = 2
			// Increment the count of active flips. This new flip starts affecting current and future positions.
			currentFlips++
		}
	}

	return ans
}