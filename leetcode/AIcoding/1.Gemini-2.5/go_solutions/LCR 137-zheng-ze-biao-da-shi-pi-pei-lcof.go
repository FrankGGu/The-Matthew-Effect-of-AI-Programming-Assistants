func isMatch(s string, p string) bool {
	ls := len(s)
	lp := len(p)

	dp := make([][]bool, ls+1)
	for i := range dp {
		dp[i] = make([]bool, lp+1)
	}

	dp[0][0] = true

	for j := 1; j <= lp; j++ {
		if p[j-1] == '*' {
			dp[0][j] = dp[0][j-1]
		}
	}

	for i := 1; i <= ls; i++ {
		for j := 1; j <= lp; j++ {
			sChar := s[i-1]
			pChar := p[j-1]

			if pChar == sChar || pChar == '?' {
				dp[i][j] = dp[i-1][j-1]
			} else if pChar == '*' {
				dp[i][j] = dp[i][j-1] || dp[i-1][j]
			}
		}
	}

	return dp[ls][lp]
}