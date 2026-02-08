func equalSumGrid(grid [][]int) int {
	n := len(grid)
	m := len(grid[0])
	totalSum := 0
	for i := 0; i < n; i++ {
		for j := 0; j < m; j++ {
			totalSum += grid[i][j]
		}
	}

	if totalSum%2 != 0 {
		return 0
	}

	targetSum := totalSum / 2
	dp := make([][]bool, n+1)
	for i := range dp {
		dp[i] = make([]bool, targetSum+1)
	}
	dp[0][0] = true

	for i := 1; i <= n; i++ {
		for j := 1; j <= m; j++ {
			for k := 0; k <= targetSum; k++ {
				dp[i][k] = dp[i-1][k]
				if k >= grid[i-1][j-1] {
					dp[i][k] = dp[i][k] || dp[i-1][k-grid[i-1][j-1]]
				}
			}
		}
	}

	if dp[n][targetSum] {
		return 1
	}
	return 0
}