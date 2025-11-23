func orderOfLargestPlusSign(n int, mines [][]int) int {
	grid := make([][]int, n)
	for i := range grid {
		grid[i] = make([]int, n)
		for j := range grid[i] {
			grid[i][j] = 1 // Initialize all