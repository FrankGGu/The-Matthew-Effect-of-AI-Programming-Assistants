func numRollsToTarget(n int, k int, target int) int {
	const MOD = 1000000007
	dp := make([][]int, n+1)
	for i := 0; i <= n; i++ {
		dp[i] = make([]int, target+1)
	}
	dp[0][0] = 1

	for i := 1; i <= n; i++ {
		for j := 1; j <= target; j++ {
			for x := 1; x <= k; x++ {
				if j >= x {
					dp[i][j] = (dp[i][j] + dp[i-1][j-x]) % MOD
				}
			}
		}
	}

	return dp[n][target]
}