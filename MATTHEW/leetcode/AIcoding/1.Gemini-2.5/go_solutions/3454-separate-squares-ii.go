func separateSquaresII(N int, K int, counts []int) [][]int {
	grid := make([][]int, N)
	for i := range grid {
		grid[i] = make([]int, N)
	}

	// Calculate total number of squares to place
	totalSquares