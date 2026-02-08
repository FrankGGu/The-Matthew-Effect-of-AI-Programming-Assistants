func countPalindromicSubsequences(s string) int {
	n := len(s)
	dp := make([][][]int, n)
	for i := range dp {
		dp[i] = make([][]int, n)
		for j := range dp[i] {
			dp[i][j] = make([]int, 4)
		}
	}

	mod := 1000000007

	for length := 1; length <= n; length++ {
		for i := 0; i <= n-length; i++ {
			j := i + length - 1
			for k := 0; k < 4; k++ {
				char := 'a' + rune(k)
				if length == 1 {
					if rune(s[i]) == char {
						dp[i][j][k] = 1
					} else {
						dp[i][j][k] = 0
					}
				} else {
					if rune(s[i]) == char && rune(s[j]) == char {
						dp[i][j][k] = 2
						for l := 0; l < 4; l++ {
							dp[i][j][k] = (dp[i][j][k] + dp[i+1][j-1][l]) % mod
						}
					} else if rune(s[i]) == char {
						dp[i][j][k] = dp[i][j-1][k]
					} else if rune(s[j]) == char {
						dp[i][j][k] = dp[i+1][j][k]
					} else {
						dp[i][j][k] = dp[i+1][j-1][k]
					}
				}
			}
		}
	}

	result := 0
	for k := 0; k < 4; k++ {
		result = (result + dp[0][n-1][k]) % mod
	}

	return result
}