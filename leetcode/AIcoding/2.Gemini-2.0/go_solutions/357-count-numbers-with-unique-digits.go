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
		dp[i] = dp[i-1] + (dp[i-1]-dp[i-2])*(10-i+1)
		if i == 2 {
			dp[i] = 81 + 10
		} else {
			temp := 9
			for j := 1; j < i; j++ {
				temp *= (10 - j)
			}
			dp[i] = dp[i-1] + temp
		}
	}
	return dp[n]
}