func minSwaps(grid [][]int) int {
	n := len(grid)

	// Step 1: For each row, find the index of the first '1'.
	// If a row contains all zeros, its firstOneIndex is n.
	// This value represents the number of leading zeros.
	// The problem states: "the i-th row contains only zeros in its first i cells."
	// This means grid[i][0]...grid[i][i-1] must be zeros.
	// This is equivalent to saying that the first '1' (if any) must appear at an index >= i.
	// If the row is all zeros, it satisfies the condition for any i.
	firstOneIndices := make([]int, n)
	for i := 0; i < n; i++ {
		firstOneIdx := n // Default to n if all zeros (meaning n leading zeros)
		for j := 0; j < n; j++ {
			if grid[i][j] == 1 {
				firstOneIdx = j
				break
			}
		}
		firstOneIndices[i] = firstOneIdx
	}

	totalSwaps := 0

	// Step 2: Greedily arrange rows
	// Iterate through each target row position 'i' from 0 to n-1.
	for i := 0; i < n; i++ {
		// For the i-th row (0-indexed), it must have its first '1' at an index >= i.
		// i.e., firstOneIndices[current_row_at_pos_i] >= i
		requiredFirstOneIndex := i

		// Find the first available row (from current position 'i' onwards)
		// that satisfies the condition for the current target row 'i'.
		foundIdx := -1
		for j := i; j < n; j++ {
			if firstOneIndices[j] >= requiredFirstOneIndex {
				foundIdx = j
				break
			}
		}

		// If no suitable row is found among the remaining rows,
		// it's impossible to make the grid valid.
		if foundIdx == -1 {
			return -1
		}

		// Add the number of swaps needed to bring this row to position 'i'.
		// If the suitable row is at index 'j', it takes 'j - i' adjacent swaps
		// to move it to position 'i'.
		totalSwaps += (foundIdx - i)

		// Shift the elements in the firstOneIndices array to reflect the swap.
		// The row that was at 'foundIdx' is now at 'i'.
		// Rows 'i' through 'foundIdx-1' are shifted one position down (to the right).
		valToMove := firstOneIndices[foundIdx]
		for k := foundIdx; k > i; k-- {
			firstOneIndices[k] = firstOneIndices[k-1]
		}
		firstOneIndices[i] = valToMove
	}

	return totalSwaps
}