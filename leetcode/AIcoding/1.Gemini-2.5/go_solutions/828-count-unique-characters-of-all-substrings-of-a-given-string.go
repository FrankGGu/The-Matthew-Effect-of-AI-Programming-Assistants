func uniqueLetterString(s string) int {
	n := len(s)

	// pos[char - 'A'] stores the indices where char appears.
	// Initialize with -1 to handle boundary conditions for the first occurrence.
	pos := make([][]int, 26)
	for i := 0; i < 26; i++ {
		pos[i] = []int{-1} // Add a sentinel -1 at the beginning
	}

	// Populate pos with actual indices
	for i := 0; i < n; i++ {
		charIdx := s[i] - 'A'
		pos[charIdx] = append(pos[charIdx], i)
	}

	// Add a sentinel n at the end for boundary conditions for the last occurrence.
	for i := 0; i < 26; i++ {
		pos[i] = append(pos[i], n) // Add a sentinel n at the end
	}

	var totalUniqueCount int64 // Use int64 to prevent overflow, as sum can be large

	// Calculate contributions for each character
	for i := 0; i < 26; i++ {
		// For each character, iterate through its occurrences (excluding sentinels)
		for j := 1; j < len(pos[i])-1; j++ {
			currentIdx := pos[i][j]
			prevIdx := pos[i][j-1]
			nextIdx := pos[i][j+1]

			// The number of substrings where s[currentIdx] is a unique character
			// is determined by the choices for its left and right boundaries.
			// Left boundary L can be any index from (prevIdx + 1) to currentIdx.
			// Number of choices for L: currentIdx - (prevIdx + 1) + 1 = currentIdx - prevIdx.
			leftChoices := currentIdx - prevIdx

			// Right boundary R can be any index from currentIdx to (nextIdx - 1).
			// Number of choices for R: (nextIdx - 1) - currentIdx + 1 = nextIdx - currentIdx.
			rightChoices := nextIdx - currentIdx

			totalUniqueCount += int64(leftChoices) * int64(rightChoices)
		}
	}

	return int(totalUniqueCount)
}