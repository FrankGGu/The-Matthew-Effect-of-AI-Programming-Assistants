func minSideJumps(obstacles []int) int {
	n := len(obstacles)
	dp := make([]int, 4)
	for i := 1; i <= 3; i++ {
		dp[i] = int(1e9)
	}
	dp[1] = 0

	for i := 0; i < n; i++ {
		next := make([]int, 4)
		for j := 1; j <= 3; j++ {
			next[j] = dp[j]
		}
		if obstacles[i] == 0 {
			for j := 1; j <= 3; j++ {
				next[j] = min(next[j], dp[j])
				if j > 1 {
					next[j] = min(next[j], dp[j-1]+1)
				}
				if j < 3 {
					next[j] = min(next[j], dp[j+1]+1)
				}
			}
		} else {
			next[obstacles[i]] = int(1e9)
			for j := 1; j <= 3; j++ {
				if j > 1 {
					next[j] = min(next[j], dp[j-1]+1)
				}
				if j < 3 {
					next[j] = min(next[j], dp[j+1]+1)
				}
			}
		}
		dp = next
	}
	return min(dp[2], dp[3])
}

func min(a, b int) int {
	if a < b {
		return a
	}
	return b
}