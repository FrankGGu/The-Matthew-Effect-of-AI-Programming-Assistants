func max(a, b int) int {
	if a > b {
		return a
	}
	return b
}

func solve(s string, k int, zero, one int) int {
	n := len(s)
	dp := make([][]int, n+1)
	for i := range dp {
		dp[i] = make([]int, k+1)
	}

	for i := 1; i <= n; i++ {
		for j := 1; j <= k; j++ {
			dp[i][j] = dp[i-1][j]
			for l := 1; l <= i; l++ {
				sub := s[i-l:i]
				zeroCount := 0
				oneCount := 0
				for _, c := range sub {
					if c == '0' {
						zeroCount++
					} else {
						oneCount++
					}
				}
				if zeroCount == zero && oneCount == one {
					dp[i][j] = max(dp[i][j], dp[i-l][j-1]+1)
				}
			}
		}
	}
	return dp[n][k]
}

func maxSubstrings(s string, k int, zero int, one int) int {
	return solve(s, k, zero, one)
}