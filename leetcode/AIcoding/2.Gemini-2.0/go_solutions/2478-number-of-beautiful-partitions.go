func beautifulPartitions(s string, k int, minLength int) int {
	n := len(s)
	if !isBeautiful(s[0]) {
		return 0
	}
	if !isNotBeautiful(s[n-1]) {
		return 0
	}
	if n < k*minLength {
		return 0
	}

	dp := make([][]int, n+1)
	for i := range dp {
		dp[i] = make([]int, k+1)
	}
	dp[n][0] = 1
	mod := 1000000007

	for i := n - 1; i >= 0; i-- {
		for j := 1; j <= k; j++ {
			if n-i < j*minLength {
				continue
			}
			if isBeautiful(s[i]) {
				for l := i + minLength; l <= n; l++ {
					dp[i][j] = (dp[i][j] + dp[l][j-1]) % mod
				}
			}
		}
	}

	return dp[0][k]
}

func isBeautiful(c byte) bool {
	return c == '2' || c == '3' || c == '5' || c == '7'
}

func isNotBeautiful(c byte) bool {
	return c != '2' && c != '3' && c != '5' && c != '7'
}