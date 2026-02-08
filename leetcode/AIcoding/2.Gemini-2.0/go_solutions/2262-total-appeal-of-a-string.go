func appealSum(s string) int64 {
	n := len(s)
	dp := make([]int, n)
	last := make(map[rune]int)
	var ans int64
	for i, c := range s {
		if j, ok := last[c]; ok {
			dp[i] = dp[i-1] + i - j
		} else {
			dp[i] = dp[i-1] + i + 1
		}
		ans += int64(dp[i])
		last[c] = i
	}
	return ans
}