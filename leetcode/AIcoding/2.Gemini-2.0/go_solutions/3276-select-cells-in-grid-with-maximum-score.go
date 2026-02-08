func max(a, b int) int {
	if a > b {
		return a
	}
	return b
}

func maxScore(grid [][]int) int64 {
	m := len(grid)
	n := len(grid[0])
	dp := make([][]int, m)
	for i := range dp {
		dp[i] = make([]int, n)
	}

	for i := 0; i < m; i++ {
		for j := 0; j < n; j++ {
			if (i+j)%2 == 0 {
				dp[i][j] = grid[i][j]
			}
		}
	}

	var ans int64 = 0
	for i := 0; i < m; i++ {
		for j := 0; j < n; j++ {
			if dp[i][j] != 0 {
				ans += int64(dp[i][j])
			}
		}
	}

	return ans
}