import (
	"math"
)

func minPathCost(grid [][]int, moveCost [][]int) int {
	m := len(grid)
	n := len(grid[0])
	dp := make([][]int, m)
	for i := range dp {
		dp[i] = make([]int, n)
	}

	for j := 0; j < n; j++ {
		dp[0][j] = grid[0][j]
	}

	for i := 1; i < m; i++ {
		for j := 0; j < n; j++ {
			dp[i][j] = math.MaxInt32
			for k := 0; k < n; k++ {
				cost := dp[i-1][k] + moveCost[grid[i-1][k]][j] + grid[i][j]
				dp[i][j] = min(dp[i][j], cost)
			}
		}
	}

	result := math.MaxInt32
	for j := 0; j < n; j++ {
		result = min(result, dp[m-1][j])
	}

	return result
}

func min(a, b int) int {
	if a < b {
		return a
	}
	return b
}