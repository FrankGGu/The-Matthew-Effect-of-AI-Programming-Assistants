func countGoodIntegers(n int) int {
	const MOD = 1000000007
	dp := make([][]int, n+1)
	for i := range dp {
		dp[i] = make([]int, 10)
	}

	for i := 0; i < 10; i++ {
		dp[1][i] = 1
	}

	for i := 2; i <= n; i++ {
		for j := 0; j < 10; j++ {
			for k := j; k < 10; k++ {
				dp[i][j] = (dp[i][j] + dp[i-1][k]) % MOD
			}
		}
	}

	ans := 0
	for i := 0; i < 10; i++ {
		ans = (ans + dp[n][i]) % MOD
	}

	return ans
}