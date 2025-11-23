func countNumbersWithUniqueDigits(n int) int {
	if n == 0 {
		return 1
	}
	if n > 10 {
		n = 10
	}
	dp := make([]int, n+1)
	dp[0] = 1
	dp[1] = 10
	for i := 2; i <= n; i++ {
		dp[i] = dp[i-1] + (dp[i-1]-dp[i-2])*(10-(i-1))
	}
	return dp[n]
}