func countSquares(matrix [][]int) int {
	n := len(matrix)
	m := len(matrix[0])
	dp := make([][]int, n)
	for i := range dp {
		dp[i] = make([]int, m)
	}
	count := 0
	for i := 0; i < n; i++ {
		for j := 0; j < m; j++ {
			if matrix[i][j] == 1 {
				if i == 0 || j == 0 {
					dp[i][j] = 1
				} else {
					dp[i][j] = min(dp[i-1][j], min(dp[i][j-1], dp[i-1][j-1])) + 1
				}
				count += dp[i][j]
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