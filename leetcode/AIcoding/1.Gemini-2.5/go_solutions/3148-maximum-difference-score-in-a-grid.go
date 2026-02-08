import "math"

func maxDifference(grid [][]int) int {
	m := len(grid)
	n := len(grid[0])

	// dp[r][c] stores the minimum value encountered in the subgrid grid[0...r][0...c].
	// This is effectively `min_so_far`