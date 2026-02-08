func superEggDrop(k int, n int) int {
	dp := make([][]int, k+1)
	for i := range dp {
		dp[i] = make([]int, n+1)
	}

	for m := 1; m <= n; m++ {
		for i := 1; i <= k; i++ {
			dp[i][m] = dp[i-1][m-1] + dp[i][m-1] + 1
			if dp[i][m] >= n {
				return m
			}
		}
	}

	return n
}