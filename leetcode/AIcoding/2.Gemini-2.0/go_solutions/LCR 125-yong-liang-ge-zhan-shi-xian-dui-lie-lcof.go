import "sort"

func minimumDeletions(books [][]int) int {
	n := len(books)
	dp := make([]int, n)
	dp[0] = books[0][1]

	for i := 1; i < n; i++ {
		dp[i] = dp[i-1] + books[i][1]
		for j := 0; j < i; j++ {
			if books[i][0] > books[j][0] {
				curr := 0
				if j > 0 {
					curr = dp[j-1]
				}
				curr += dp[i] - dp[j] - books[j][1]
				dp[i] = min(dp[i], curr)
			}
		}
	}

	sum := 0
	for _, book := range books {
		sum += book[1]
	}
	return dp[n-1]
}

func min(a, b int) int {
	if a < b {
		return a
	}
	return b
}