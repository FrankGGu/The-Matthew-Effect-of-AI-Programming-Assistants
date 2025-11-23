func firstDayBeenInAllRooms(nextVisit []int) int {
	n := len(nextVisit)
	dp := make([]int, n)
	dp[0] = 0
	for i := 0; i < n-1; i++ {
		j := nextVisit[i]
		if j < i {
			dp[i+1] = (dp[i] + 1 + (dp[i] - dp[j])) % 1000000007
		} else {
			dp[i+1] = (dp[i] + 2) % 1000000007
		}
	}
	return dp[n-1]
}