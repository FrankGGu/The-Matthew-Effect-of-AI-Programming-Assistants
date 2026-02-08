func max(a, b int) int {
	if a > b {
		return a
	}
	return b
}

func maxCoins(piles [][]int, k int) int {
	n := len(piles)
	dp := make([][]int, n+1)
	for i := 0; i <= n; i++ {
		dp[i] = make([]int, k+1)
	}

	for i := 1; i <= n; i++ {
		for j := 1; j <= k; j++ {
			sum := 0
			for x := 0; x <= min(len(piles[i-1]), j); x++ {
				if x > 0 {
					sum += piles[i-1][x-1]
				}
				dp[i][j] = max(dp[i][j], dp[i-1][j-x]+sum)
			}
		}
	}

	return dp[n][k]
}

func min(a, b int) int {
	if a < b {
		return a
	}
	return b
}