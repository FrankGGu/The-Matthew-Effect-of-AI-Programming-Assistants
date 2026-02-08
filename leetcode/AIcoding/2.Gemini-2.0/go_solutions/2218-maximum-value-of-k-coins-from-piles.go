import "fmt"

func maxValueOfCoins(piles [][]int, k int) int {
	n := len(piles)
	dp := make([][]int, n+1)
	for i := range dp {
		dp[i] = make([]int, k+1)
	}

	for i := 1; i <= n; i++ {
		for j := 0; j <= k; j++ {
			dp[i][j] = dp[i-1][j]
			currentSum := 0
			for x := 1; x <= len(piles[i-1]) && x <= j; x++ {
				currentSum += piles[i-1][x-1]
				dp[i][j] = max(dp[i][j], dp[i-1][j-x]+currentSum)
			}
		}
	}

	return dp[n][k]
}

func max(a, b int) int {
	if a > b {
		return a
	}
	return b
}