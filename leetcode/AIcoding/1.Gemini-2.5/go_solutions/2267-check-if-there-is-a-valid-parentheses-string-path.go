func hasValidPath(grid [][]byte) bool {
	m := len(grid)
	n := len(grid[0])

	// The length of any path from (0,0) to (m-1,n-1) is m + n - 1.
	// For a valid parentheses string, the total length must