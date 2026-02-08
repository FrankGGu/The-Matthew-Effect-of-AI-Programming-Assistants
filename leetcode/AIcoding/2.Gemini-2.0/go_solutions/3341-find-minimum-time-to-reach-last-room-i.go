func firstDayBeenInAllRooms(nextVisit []int) int {
	n := len(nextVisit)
	dp := make([]int, n)
	for i := 1; i < n; i++ {
		dp[i] = (dp[i-1] + 1 + (dp[i-1] + 1 - nextVisit[i-1] - dp[nextVisit[i-1]]) + 1000000007) % 1000000007
		if dp[i] < 0 {
			dp[i] += 1000000007
		}
		if dp[i] >= 1000000007 {
			dp[i] %= 1000000007
		}
	}
	return dp[n-1]
}