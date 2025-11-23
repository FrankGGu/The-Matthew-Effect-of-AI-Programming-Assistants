import "fmt"

func minimumWhiteTiles(floor string, numCarpets int, carpetLen int) int {
	n := len(floor)
	dp := make([][]int, numCarpets+1)
	for i := range dp {
		dp[i] = make([]int, n+1)
	}

	for i := 1; i <= numCarpets; i++ {
		for j := 1; j <= n; j++ {
			dp[i][j] = dp[i][j-1]
			if floor[j-1] == '1' {
				dp[i][j]++
			}

			if j >= carpetLen {
				dp[i][j] = min(dp[i][j], dp[i-1][j-carpetLen])
			} else {
				dp[i][j] = 0
			}
		}
	}

	return dp[numCarpets][n]
}

func min(a, b int) int {
	if a < b {
		return a
	}
	return b
}