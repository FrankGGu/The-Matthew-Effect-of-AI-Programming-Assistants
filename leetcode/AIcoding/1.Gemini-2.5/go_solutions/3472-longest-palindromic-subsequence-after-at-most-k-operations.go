func longestPalindromeSubsequence(s string, k int) int {
	n := len(s)
	if n == 0 {
		return 0
	}

	dp := make([][][]int, n)
	for i := range dp {
		dp[i] = make([][]int, n)
		for j := range dp[i] {
			dp[i][j] = make([]int, k+1)
		}
	}

	for i := 0; i < n; i++ {
		for k_ops := 0; k_ops <= k; k_ops++ {
			dp[i][i][k_ops] = 1
		}
	}

	for length := 2; length <= n; length++ {
		for i := 0; i <= n-length; i++ {
			j := i + length - 1
			for k_ops := 0; k_ops <= k; k_ops++ {
				dp[i][j][k_ops] = max(dp[i+1][j][k_ops], dp[i][j-1][k_ops])

				cost := 0
				if s[i] != s[j] {
					cost = 1
				}

				if k_ops >= cost {
					dp[i][j][k_ops] = max(dp[i][j][k_ops], dp[i+1][j-1][k_ops-cost]+2)
				}
			}
		}
	}

	return dp[0][n-1][k]
}

func max(a, b int) int {
	if a > b {
		return a
	}
	return b
}