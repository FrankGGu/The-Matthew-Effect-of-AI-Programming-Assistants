package main

import "math"

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

func minHeightShelves(books [][]int, shelfWidth int) int {
	n := len(books)
	dp := make([]int, n+1)

	for i := 1; i <= n; i++ {
		dp[i] = math.MaxInt32
	}

	dp[0] = 0

	for i := 1; i <= n; i++ {
		currentWidth := 0
		maxHeightInCurrentShelf := 0
		for j := i - 1; j >= 0; j-- {
			bookWidth := books[j][0]
			bookHeight := books[j][1]

			currentWidth += bookWidth
			if currentWidth > shelfWidth {
				break
			}

			maxHeightInCurrentShelf = max(maxHeightInCurrentShelf, bookHeight)
			dp[i] = min(dp[i], dp[j]+maxHeightInCurrentShelf)
		}
	}

	return dp[n]
}