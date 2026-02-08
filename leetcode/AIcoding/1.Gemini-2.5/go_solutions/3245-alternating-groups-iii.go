func numberOfAlternatingGroups(colors []int, k int) int {
	n := len(colors)

	// Create an array to mark where alternating conditions are met.
	// ones[i] = 1 if colors[i] != colors[(i+1)%n], else 0.
	// This captures the alternating property between adjacent elements in the circular array.
	ones := make([]int, n)
	for i := 0; i < n; i++ {
		if colors[i] != colors[(i+1)%n] {
			ones[i] = 1
		} else {
			ones[i] = 0
		}
	}

	// Extend the ones array to handle circularity for the sliding window.
	// An alternating group of length k requires k-1 alternating conditions to be true.
	// For example, for [c0, c1, c2], we need c0!=c1 and c1!=c2 (2 conditions for k=3).
	// So, we need to find windows of size k-1 in the 'ones' array that sum to k-1.
	// We extend by k-1 elements to avoid modulo operations when checking windows that wrap around.
	extendedOnes := make([]int, n+k-1)
	for i := 0; i < n+k-1; i++ {
		extendedOnes[i] = ones[i%n]
	}

	count := 0
	currentSum := 0

	// Calculate the initial sum for the first window of size k-1.
	// This window corresponds to the group starting at index 0.
	// If k=1, k-1=0, this loop does not run, currentSum remains 0.
	for i := 0; i < k-1; i++ {
		currentSum += extendedOnes[i]
	}

	// Check if the first window forms an alternating group.
	// If k=1, k-1=0, currentSum=0, so 0 == 0 is true, count becomes 1.
	if currentSum == k-1 {
		count++
	}

	// Slide the window for the remaining n-1 starting positions.
	// The window slides from index i to i+k-2 in the extendedOnes array.
	// 'i' here represents the starting index of the group in the original 'colors' array.
	for i := 1; i < n; i++ {
		// Remove the element leaving the window (extendedOnes[i-1])
		// Add the element entering the window (extendedOnes[i + k - 2])
		currentSum = currentSum - extendedOnes[i-1] + extendedOnes[i+k-2]
		if currentSum == k-1 {
			count++
		}
	}

	return count
}