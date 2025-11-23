func max(a, b int) int {
	if a > b {
		return a
	}
	return b
}

func maxPalindromeLength(word1 string, word2 string) int {
	s := word1 + word2
	n1 := len(word1)
	n := len(s)
	dp := make([][]int, n)
	for i := range dp {
		dp[i] = make([]int, n)
		dp[i][i] = 1
	}

	ans := 0
	for l := 2; l <= n; l++ {
		for i := 0; i <= n-l; i++ {
			j := i + l - 1
			if s[i] == s[j] {
				if l == 2 {
					dp[i][j] = 2
				} else {
					dp[i][j] = dp[i+1][j-1] + 2
				}
				if i < n1 && j >= n1 {
					ans = max(ans, dp[i][j])
				}
			} else {
				dp[i][j] = max(dp[i+1][j], dp[i][j-1])
			}
		}
	}

	return ans
}