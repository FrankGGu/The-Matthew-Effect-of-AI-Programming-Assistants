func maxSizeSlices(slices []int) int {
	n := len(slices) / 3
	slices1 := slices[:len(slices)-1]
	slices2 := slices[1:]

	return max(solve(slices1, n), solve(slices2, n))
}

func solve(slices []int, n int) int {
	m := len(slices)
	dp := make([][][]int, m+1)
	for i := range dp {
		dp[i] = make([][]int, n+1)
		for j := range dp[i] {
			dp[i][j] = make([]int, 2)
		}
	}

	for i := 1; i <= m; i++ {
		for j := 1; j <= n; j++ {
			dp[i][j][0] = max(dp[i-1][j][0], dp[i-1][j][1])
			dp[i][j][1] = dp[i-1][j-1][0] + slices[i-1]
		}
	}

	return max(dp[m][n][0], dp[m][n][1])
}

func max(a, b int) int {
	if a > b {
		return a
	}
	return b
}