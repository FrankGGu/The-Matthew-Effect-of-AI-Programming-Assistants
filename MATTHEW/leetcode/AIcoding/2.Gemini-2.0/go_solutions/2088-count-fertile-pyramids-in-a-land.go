func countFertilePyramids(grid [][]int) int64 {
	m, n := len(grid), len(grid[0])
	var count int64

	dp := make([][]int, m)
	for i := range dp {
		dp[i] = make([]int, n)
	}

	for i := m - 2; i >= 0; i-- {
		for j := 1; j < n-1; j++ {
			if grid[i][j] == 1 && grid[i+1][j-1] == 1 && grid[i+1][j] == 1 && grid[i+1][j+1] == 1 {
				dp[i][j] = min(dp[i+1][j-1], min(dp[i+1][j], dp[i+1][j+1])) + 1
				count += int64(dp[i][j])
			}
		}
	}

	dp = make([][]int, m)
	for i := range dp {
		dp[i] = make([]int, n)
	}

	for i := 1; i < m-1; i++ {
		for j := 1; j < n-1; j++ {
			if grid[i][j] == 1 && grid[i-1][j-1] == 1 && grid[i-1][j] == 1 && grid[i-1][j+1] == 1 {
				dp[i][j] = min(dp[i-1][j-1], min(dp[i-1][j], dp[i-1][j+1])) + 1
				count += int64(dp[i][j])
			}
		}
	}

	return count
}

func min(a, b int) int {
	if a < b {
		return a
	}
	return b
}