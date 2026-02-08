package main

func matrixScore(grid [][]int) int {
	rows := len(grid)
	cols := len(grid[0])

	// Step 1: Ensure the most significant bit (MSB) of each row is 1.
	// If grid[i][0] is 0, flip the entire row i.
	for i := 0; i < rows; i++ {
		if grid[i][0] == 0 {
			// Flip row i
			for j := 0; j < cols; j++ {
				grid[i][j] = 1 - grid[i][j]
			}
		}
	}

	// Initialize score with the contribution from the first column.
	// All elements in the first column are now 1s.
	// The value of the MSB is 2^(cols-1).
	score := rows * (1 << (cols - 1))

	// Step 2: For all subsequent columns (j from 1 to cols-1), maximize the number of 1s.
	for j := 1; j < cols; j++ {
		onesInCol := 0
		for i := 0; i < rows; i++ {
			if grid[i][j] == 1 {
				onesInCol++
			}
		}

		// To maximize the score for this column, choose to have max(onesInCol, zerosInCol) 1s.
		// If we flip the column, onesInCol becomes (rows - onesInCol).
		// So, we effectively take the maximum of these two counts.
		numOnesToContribute := onesInCol
		if rows-onesInCol > onesInCol {
			numOnesToContribute = rows - onesInCol
		}

		// Add the contribution of this column to the total score.
		// The value of this bit position is 2^(cols-1-j).
		score += numOnesToContribute * (1 << (cols - 1 - j))
	}

	return score
}