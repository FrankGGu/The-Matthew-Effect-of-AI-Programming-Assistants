func minSkips(dist []int, speed int, hoursBefore int) int {
	n := len(dist)
	dp := make([][]int, n+1)
	for i := 0; i <= n; i++ {
		dp[i] = make([]int, n+1)
		for j := 0; j <= n; j++ {
			dp[i][j] = 1e9
		}
	}
	dp[0][0] = 0

	for i := 1; i <= n; i++ {
		for j := 0; j <= n; j++ {
			dp[i][j] = min(dp[i][j], (dp[i-1][j]+dist[i-1]+speed-1)/speed*speed)
			if j > 0 {
				dp[i][j] = min(dp[i][j], dp[i-1][j-1]+dist[i-1])
			}
		}
	}

	ans := -1
	totalHours := hoursBefore * speed
	for j := 0; j <= n; j++ {
		if dp[n][j] <= totalHours {
			ans = j
			break
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