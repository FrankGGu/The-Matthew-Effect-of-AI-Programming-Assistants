func diagonalSum(mat [][]int) int {
	n := len(mat)
	totalSum := 0

	for i := 0; i < n; i++ {
		// Add primary diagonal element
		totalSum += mat[i][i]
		// Add secondary diagonal element
		totalSum += mat[i][n-1-i]
	}

	// If n is odd, the center element was added twice
	// (once from primary diagonal, once from secondary diagonal).
	// Subtract it once to correct the sum.
	if n%2 == 1 {
		totalSum -= mat[n/2][n/2]
	}

	return totalSum
}