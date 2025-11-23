func max(a, b int) int {
	if a > b {
		return a
	}
	return b
}

func maxScore(grid [][]int) int {
	m, n := len(grid), len(grid[0])
	dp := make([][]int, m)
	for i := range dp {
		dp[i] = make([]int, n)
	}

	dp[0][0] = grid[0][0]
	for i := 1; i < n; i++ {
		dp[0][i] = dp[0][i-1] + grid[0][i]
	}

	for i := 1; i < m; i++ {
		left := make([]int, n)
		right := make([]int, n)

		left[0] = dp[i-1][0] + grid[i][0]
		for j := 1; j < n; j++ {
			left[j] = max(left[j-1], dp[i-1][j]) + grid[i][j]
		}

		right[n-1] = dp[i-1][n-1] + grid[i][n-1]
		for j := n - 2; j >= 0; j-- {
			right[j] = max(right[j+1], dp[i-1][j]) + grid[i][j]
		}

		for j := 0; j < n; j++ {
			dp[i][j] = max(left[j], right[j])
		}
	}

	return dp[m-1][n-1]
}