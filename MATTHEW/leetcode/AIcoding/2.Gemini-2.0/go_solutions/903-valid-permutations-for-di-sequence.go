func numPermsDISequence(n int, s string) int {
	mod := 1000000007
	dp := make([][]int, n+1)
	for i := range dp {
		dp[i] = make([]int, n+1)
	}

	for i := 0; i <= n; i++ {
		dp[0][i] = 1
	}

	for i := 1; i <= n; i++ {
		sum := 0
		if s[i-1] == 'I' {
			for j := 0; j < i; j++ {
				sum = (sum + dp[i-1][j]) % mod
				dp[i][j] = sum
			}
		} else {
			for j := i - 1; j >= 0; j-- {
				sum = (sum + dp[i-1][j+1]) % mod
				dp[i][j] = sum
			}
		}
	}

	ans := 0
	for i := 0; i <= n; i++ {
		ans = (ans + dp[n][i]) % mod
	}

	return ans
}