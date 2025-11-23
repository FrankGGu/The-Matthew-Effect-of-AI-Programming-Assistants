func goodSubsetofBinaryMatrix(grid [][]int) []int {
	m := len(grid)
	n := len(grid[0])

	// Map to store the first 0-indexed row number for each unique mask encountered.
	// mask -> row_index
	seenMasks := make(map[int]int)

	for i := 0; i < m; i++ {
		currentMask := 0
		for j := 0; j < n; j++ {
			if grid[i][j] == 1 {
				currentMask |= (1 << j)
			}
		}

		// Case 1: If the current row is an all-zero row (mask is 0),
		// then this single row forms a good subset.
		if currentMask == 0 {
			return []int{i + 1}
		}

		// Case 2: Check if the current row can form a good subset with any previously seen row.
		// A good subset {r_a, r_b} means (mask_a & mask_b) == 0.
		// (Assuming the problem meant bitwise AND based on typical LeetCode patterns and example discrepancy)
		for prevMask, prevIdx := range seenMasks {
			if (currentMask & prevMask) == 0 {
				// Found two rows whose bitwise AND is 0.
				// Return their 1-indexed row numbers.
				return []int{prevIdx + 1, i + 1}
			}
		}

		// If currentMask hasn't been seen before, store its first occurrence.
		if _, exists := seenMasks[currentMask]; !exists {
			seenMasks[currentMask] = i
		}
	}

	// If no good subset is found after checking all rows, return an empty slice.
	return []int{}
}