func longestPalindromicSubsequence(s string) int {
	n := len(s)
	if n == 0 {
		return 0
	}

	dp := make([][]int, n)
	for i := range dp {
		dp[i] = make([]int, n)
		dp[i][i] = 1
	}

	for length := 2; length <= n; length++ {
		for i := 0; i <= n-length; i++ {
			j := i + length - 1
			if s[i] == s[j] {
				if length == 2 {
					dp[i][j] = 2
				} else {
					dp[i][j] = 2 + dp[i+1][j-1]
				}
			} else {
				dp[i][j] = max(dp[i+1][j], dp[i][j-1])
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

func maxProduct(s string) int {
	n := len(s)
	maxProd := 0

	for i := 0; i < (1 << n); i++ {
		s1Str := ""
		s2Str := ""

		for j := 0; j < n; j++ {
			if (i >> j) & 1 == 1 {
				s1Str += string(s[j])
			} else {
				s2Str += string(s[j])
			}
		}

		lps1 := longestPalindromicSubsequence(s1Str)
		lps2 := longestPalindromicSubsequence(s2Str)

		maxProd = max(maxProd, lps1*lps2)
	}

	return maxProd
}