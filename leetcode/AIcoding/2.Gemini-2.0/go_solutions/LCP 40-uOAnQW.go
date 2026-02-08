func cardGame(cards []int) int {
	n := len(cards)
	dp := make([]int, n+1)

	for i := n - 1; i >= 0; i-- {
		dp[i] = cards[i] - dp[i+1]
		if i+2 <= n {
			dp[i] = max(dp[i], cards[i]+cards[i+1]-dp[i+2])
		}
		if i+3 <= n {
			dp[i] = max(dp[i], cards[i]+cards[i+1]+cards[i+2]-dp[i+3])
		}
	}

	return dp[0]
}

func max(a, b int) int {
	if a > b {
		return a
	}
	return b
}