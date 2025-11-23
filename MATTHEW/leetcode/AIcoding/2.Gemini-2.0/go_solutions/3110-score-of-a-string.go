func scoreOfAString(s string) int {
	n := len(s)
	dp := make([][]int, n)
	for i := range dp {
		dp[i] = make([]int, n)
	}

	for i := 0; i < n; i++ {
		dp[i][i] = 1
	}

	for length := 2; length <= n; length++ {
		for i := 0; i <= n-length; i++ {
			j := i + length - 1
			if s[i] == '(' && s[j] == ')' {
				dp[i][j] = 2 * dp[i+1][j-1]
			} else {
				for k := i; k < j; k++ {
					dp[i][j] = max(dp[i][j], dp[i][k]+dp[k+1][j])
				}
			}
		}
	}

	return dp[0][n-1]
}

func max(a, b int) int {
	if a > b {
		return a
	}
	return b
}