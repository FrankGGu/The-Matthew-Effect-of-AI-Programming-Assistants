func minHeightShelves(books [][]int, shelfWidth int) int {
	n := len(books)
	dp := make([]int, n+1)
	dp[0] = 0

	for i := 1; i <= n; i++ {
		width := 0
		height := 0
		dp[i] = dp[i-1] + books[i-1][1]
		for j := i; j >= 1; j-- {
			width += books[j-1][0]
			if width > shelfWidth {
				break
			}
			height = max(height, books[j-1][1])
			dp[i] = min(dp[i], dp[j-1]+height)
		}
	}

	return dp[n]
}

func min(a, b int) int {
	if a < b {
		return a
	}
	return b
}

func max(a, b int) int {
	if a > b {
		return a
	}
	return b
}