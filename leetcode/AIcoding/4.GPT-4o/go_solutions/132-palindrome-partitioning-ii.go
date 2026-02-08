func minCut(s string) int {
	n := len(s)
	if n == 0 {
		return 0
	}

	dp := make([]int, n+1)
	for i := 0; i <= n; i++ {
		dp[i] = n - i
	}

	isPal := make([][]bool, n)
	for i := 0; i < n; i++ {
		isPal[i] = make([]bool, n)
	}

	for i := n - 1; i >= 0; i-- {
		for j := i; j < n; j++ {
			if s[i] == s[j] && (j-i < 2 || isPal[i+1][j-1]) {
				isPal[i][j] = true
				dp[i] = min(dp[i], dp[j+1]+1)
			}
		}
	}
	return dp[0] - 1
}

func min(a, b int) int {
	if a < b {
		return a
	}
	return b
}