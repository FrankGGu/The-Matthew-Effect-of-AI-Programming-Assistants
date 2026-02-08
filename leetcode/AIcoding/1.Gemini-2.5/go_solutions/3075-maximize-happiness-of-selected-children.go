func maxHappinessSum(happiness []int, k int) int64 {
	// Sort the happiness values in descending order.
	// This ensures that we always pick the child with the highest initial happiness first.
	sort.Slice(happiness, func(i, j int) bool {
		return happiness[i] > happiness[j]
	})

	var totalHappiness int64 = 0

	// Iterate k times to select k children.
	// The variable 'i' will represent the number of children already picked
	// before the current child at index 'i' in the sorted array.
	for i := 0; i < k; i++ {
		// Calculate the effective happiness for the current child.
		// Their happiness decreases by 'i' (the number of previously selected children).
		effectiveHappiness := happiness[i] - i

		// If the effective happiness becomes negative, it should be considered 0.
		if effectiveHappiness < 0 {
			effectiveHappiness = 0
		}

		// Add the effective happiness to the total sum.
		totalHappiness += int64(effectiveHappiness)
	}

	return totalHappiness
}