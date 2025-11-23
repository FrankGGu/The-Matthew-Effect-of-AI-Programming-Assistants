func idealArrays(n int, maxValue int) int {
	const mod int = 1e9 + 7
	dp := make([][]int, n+1)
	for i := range dp {
		dp[i] = make([]int, maxValue+1)
	}

	for j := 1; j <= maxValue; j++ {
		dp[1][j] = 1
	}

	for i := 2; i <= n; i++ {
		for j := 1; j <= maxValue; j++ {
			for k := 2 * j; k <= maxValue; k += j {
				dp[i][j] = (dp[i][j] + dp[i-1][k]) % mod
			}
		}
	}

	ans := 0
	for j := 1; j <= maxValue; j++ {
		ans = (ans + dp[n][j]) % mod
	}

	return ans
}