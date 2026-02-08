func numTilings(n int) int {
	if n <= 2 {
		return n
	}
	mod := 1000000007
	dp := make([]int, n+1)
	dp[0] = 1
	dp[1] = 1
	dp[2] = 2
	for i := 3; i <= n; i++ {
		dp[i] = (2*dp[i-1] + dp[i-3]) % mod
	}
	return dp[n]
}