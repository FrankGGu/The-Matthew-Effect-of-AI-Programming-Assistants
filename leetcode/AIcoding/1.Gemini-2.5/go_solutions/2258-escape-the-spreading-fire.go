func maximumMinutes(grid [][]int) int {
	m := len(grid)
	n := len(grid[0])

	// Directions for BFS
	dirs := []int{-1, 0, 1, 0, -1} // dx