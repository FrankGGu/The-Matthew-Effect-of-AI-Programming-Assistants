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

	for i := n - 1; i >= 0; i-- {
		for j := i; j < n; j++ {
			for k := 0; k < 4; k++ {
				if i == j {
					if int(s[i]-'a') == k {
						dp[i][j][k] = 1
					} else {
						dp[i][j][k] = 0
					}
					continue
				}

				if int(s[i]-'a') != k {
					dp[i][j][k] = dp[i+1][j][k]
				} else if int(s[j]-'a') != k {
					dp[i][j][k] = dp[i][j-1][k]
				} else {
					count := 0
					for l := 0; l < 4; l++ {
						count = (count + dp[i+1][j-1][l]) % mod
					}
					dp[i][j][k] = (2 + count) % mod
				}
			}
		}
	}

	result := 0
	for i := 0; i < 4; i++ {
		result = (result + dp[0][n-1][i]) % mod
	}

	return result
}