func maxValueOfGifts(gifts [][]int) int {
	m := len(gifts)
	n := len(gifts[0])
	dp := make([][]int, m)
	for i := range dp {
		dp[i] = make([]int, n)
	}
	dp[0][0] = gifts[0][0]
	for i := 0; i < m; i++ {
		for j := 0; j < n; j++ {
			if i == 0 && j == 0 {
				continue
			}
			up := 0
			left := 0
			if i > 0 {
				up = dp[i-1][j]
			}
			if j > 0 {
				left = dp[i][j-1]
			}
			dp[i][j] = max(up, left) + gifts[i][j]
		}
	}
	return dp[m-1][n-1]
}

func max(a, b int) int {
	if a > b {
		return a
	}
	return b
}