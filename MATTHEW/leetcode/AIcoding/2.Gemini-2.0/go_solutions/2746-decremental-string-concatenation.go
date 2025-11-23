func minimizeConcatenatedLength(words []string) int {
	n := len(words)
	dp := make([][26][26]int, n+1)
	for i := range dp {
		for j := range dp[i] {
			for k := range dp[j] {
				dp[i][j][k] = 1 << 30
			}
		}
	}

	dp[0][0][0] = 0
	for i := 0; i < n; i++ {
		w := words[i]
		l := len(w)
		first := int(w[0] - 'a')
		last := int(w[l-1] - 'a')

		for j := 0; j < 26; j++ {
			for k := 0; k < 26; k++ {
				if dp[i][j][k] == 1<<30 {
					continue
				}
				cost1 := l
				if k == first {
					cost1--
				}

				cost2 := l
				if j == last {
					cost2--
				}

				dp[i+1][j][last] = min(dp[i+1][j][last], dp[i][j][k] + cost1)
				dp[i+1][first][k] = min(dp[i+1][first][k], dp[i][j][k] + cost2)
			}
		}
	}

	ans := 1 << 30
	for i := 0; i < 26; i++ {
		for j := 0; j < 26; j++ {
			ans = min(ans, dp[n][i][j])
		}
	}
	return ans
}

func min(a, b int) int {
	if a < b {
		return a
	}
	return b
}