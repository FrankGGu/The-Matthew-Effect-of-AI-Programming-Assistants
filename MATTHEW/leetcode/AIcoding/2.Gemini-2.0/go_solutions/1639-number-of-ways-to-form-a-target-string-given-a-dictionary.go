func numWays(words []string, target string) int {
	mod := int(1e9 + 7)
	m := len(target)
	n := len(words[0])
	count := make([][]int, 26)
	for i := range count {
		count[i] = make([]int, n)
	}
	for _, word := range words {
		for i, c := range word {
			count[c-'a'][i]++
		}
	}

	dp := make([][]int, m+1)
	for i := range dp {
		dp[i] = make([]int, n+1)
	}
	dp[0][0] = 1

	for i := 0; i <= m; i++ {
		for j := 0; j < n; j++ {
			if dp[i][j] == 0 {
				continue
			}
			dp[i][j+1] = (dp[i][j+1] + dp[i][j]) % mod
			if i < m {
				dp[i+1][j+1] = (dp[i+1][j+1] + (dp[i][j] * count[target[i]-'a'][j]) % mod) % mod
			}
		}
	}

	return dp[m][n]
}