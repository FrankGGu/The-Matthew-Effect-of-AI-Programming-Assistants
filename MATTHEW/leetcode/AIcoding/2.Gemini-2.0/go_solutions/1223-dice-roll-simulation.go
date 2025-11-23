func dieSimulator(n int, rollMax []int) int {
	mod := 1000000007
	dp := make([][]int, n+1)
	for i := range dp {
		dp[i] = make([]int, 6)
	}
	sum := make([]int, n+1)
	sum[0] = 1

	for i := 1; i <= n; i++ {
		for j := 0; j < 6; j++ {
			for k := 1; k <= rollMax[j] && i-k >= 0; k++ {
				if i-k == 0 {
					dp[i][j] = (dp[i][j] + 1) % mod
				} else {
					dp[i][j] = (dp[i][j] + sum[i-k] - dp[i-k][j] + mod) % mod
				}
			}
			sum[i] = (sum[i] + dp[i][j]) % mod
		}
	}

	return sum[n]
}