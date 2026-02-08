import "math"

func cherryPickup(grid [][]int) int {
	rows := len(grid)
	cols := len(grid[0])

	// dp[r][c1][c2] stores the maximum cherries collected
	// from row r down to rows-1, given robot1 is at (r, c