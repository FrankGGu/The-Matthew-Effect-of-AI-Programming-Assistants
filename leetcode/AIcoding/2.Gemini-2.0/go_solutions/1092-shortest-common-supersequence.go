func shortestCommonSupersequence(str1 string, str2 string) string {
	n, m := len(str1), len(str2)
	dp := make([][]string, n+1)
	for i := 0; i <= n; i++ {
		dp[i] = make([]string, m+1)
	}

	for i := 0; i <= n; i++ {
		for j := 0; j <= m; j++ {
			if i == 0 {
				dp[i][j] = str2[:j]
			} else if j == 0 {
				dp[i][j] = str1[:i]
			} else if str1[i-1] == str2[j-1] {
				dp[i][j] = dp[i-1][j-1] + string(str1[i-1])
			} else {
				if len(dp[i-1][j]) < len(dp[i][j-1]) {
					dp[i][j] = dp[i-1][j] + string(str1[i-1])
				} else {
					dp[i][j] = dp[i][j-1] + string(str2[j-1])
				}
			}
		}
	}

	return dp[n][m]
}