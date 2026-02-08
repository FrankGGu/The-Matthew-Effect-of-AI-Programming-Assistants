func longestArithSeqLength(arr []int, difference int) int {
	dp := make(map[int]map[int]int)
	ans := 1
	for i := 0; i < len(arr); i++ {
		if dp[arr[i]] == nil {
			dp[arr[i]] = make(map[int]int)
		}
		dp[arr[i]][i] = 1
		prev := arr[i] - difference
		for j := 0; j < i; j++ {
			if arr[j] == prev {
				if dp[arr[i]] == nil {
					dp[arr[i]] = make(map[int]int)
				}
				if dp[prev] != nil && dp[prev][j] > 0 {
					dp[arr[i]][i] = max(dp[arr[i]][i], dp[prev][j]+1)
					ans = max(ans, dp[arr[i]][i])
				}
			}
		}
	}
	return ans
}

func max(a, b int) int {
	if a > b {
		return a
	}
	return b
}