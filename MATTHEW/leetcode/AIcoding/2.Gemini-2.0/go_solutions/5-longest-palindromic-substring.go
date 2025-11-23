func longestPalindrome(s string) string {
	n := len(s)
	if n < 2 {
		return s
	}

	dp := make([][]bool, n)
	for i := range dp {
		dp[i] = make([]bool, n)
	}

	start := 0
	maxLength := 1

	for i := 0; i < n; i++ {
		dp[i][i] = true
	}

	for i := 0; i < n-1; i++ {
		if s[i] == s[i+1] {
			dp[i][i+1] = true
			start = i
			maxLength = 2
		}
	}

	for k := 3; k <= n; k++ {
		for i := 0; i <= n-k; i++ {
			j := i + k - 1
			if s[i] == s[j] && dp[i+1][j-1] {
				dp[i][j] = true
				if k > maxLength {
					start = i
					maxLength = k
				}
			}
		}
	}

	return s[start : start+maxLength]
}