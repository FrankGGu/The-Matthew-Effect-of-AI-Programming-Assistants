import "math"

func max(a, b int) int {
	if a > b {
		return a
	}
	return b
}

func dungeon(dungeon [][]int) int {
	m := len(dungeon)
	n := len(dungeon[0])

	dp := make([][]int, m+1)
	for i := range dp {
		dp[i] = make([]int, n+1)
		for j := range dp[i] {
			dp[i][j] = math.MinInt32
		}
	}

	dp[m][n-1] = 1
	dp[m-1][n] = 1

	for i := m - 1; i >= 0; i-- {
		for j := n - 1; j >= 0; j-- {
			need := max(1, 1-dungeon[i][j])
			dp[i][j] = max(dp[i+1][j], dp[i][j+1]) - dungeon[i][j]
			dp[i][j] = max(1, dp[i][j])
		}
	}

	return dp[0][0]
}