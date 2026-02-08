func max(a, b int) int {
	if a > b {
		return a
	}
	return b
}

func min(a, b int) int {
	if a < b {
		return a
	}
	return b
}

func maxDiff(grid [][]int) int {
	m := len(grid)
	n := len(grid[0])
	dp := make([][]int, m)
	for i := 0; i < m; i++ {
		dp[i] = make([]int, n)
	}

	dp[0][0] = grid[0][0]

	for i := 1; i < m; i++ {
		dp[i][0] = min(dp[i-1][0], grid[i][0])
	}

	for j := 1; j < n; j++ {
		dp[0][j] = min(dp[0][j-1], grid[0][j])
	}

	for i := 1; i < m; i++ {
		for j := 1; j < n; j++ {
			dp[i][j] = min(max(dp[i-1][j], dp[i][j-1]), grid[i][j])
		}
	}

	ans := -1
	for i := 0; i < m; i++ {
		for j := 0; j < n; j++ {
			ans = max(ans, grid[i][j] - dp[i][j])
		}
	}

	return ans
}