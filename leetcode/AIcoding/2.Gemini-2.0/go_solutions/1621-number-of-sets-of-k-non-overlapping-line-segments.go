func numberOfSets(n int, k int) int {
	mod := 1000000007
	dp := make([][]int, n+1)
	for i := range dp {
		dp[i] = make([]int, k+1)
	}

	for i := 1; i <= n; i++ {
		dp[i][0] = 1
	}

	for j := 1; j <= k; j++ {
		sum := 0
		for i := 2; i <= n; i++ {
			sum = (sum + dp[i-1][j-1] + dp[i-1][j]) % mod
			dp[i][j] = sum
		}
	}

	return dp[n][k]
}