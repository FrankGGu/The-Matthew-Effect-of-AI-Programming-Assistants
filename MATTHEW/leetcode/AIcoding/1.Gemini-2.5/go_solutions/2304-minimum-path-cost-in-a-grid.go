import "math"

func minPathCost(grid [][]int, moveCost [][]int) int {
	m := len(grid)
	n := len(grid[0])

	// dp[r][c] will store the minimum cost to reach cell (r, c)
	// from any cell in the first row.
	dp := make