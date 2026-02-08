func stoneGame(piles []int) bool {
	n := len(piles)
	dp := make([][]int, n)
	for i := range dp {
		dp[i] = make([]int, n)
		dp[i][i] = piles[i]
	}

	for len := 2; len <= n; len++ {
		for i := 0; i <= n-len; i++ {
			j := i + len - 1
			dp[i][j] = max(piles[i]-dp[i+1][j], piles[j]-dp[i][j-1])
		}
	}

	return dp[0][n-1] > 0
}

func max(a, b int) int {
	if a > b {
		return a
	}
	return b
}