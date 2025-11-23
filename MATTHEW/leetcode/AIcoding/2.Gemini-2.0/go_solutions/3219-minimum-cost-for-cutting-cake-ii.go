import (
	"sort"
)

func minCost(cuts []int, cakeLength int) int {
	cuts = append(cuts, 0, cakeLength)
	sort.Ints(cuts)
	n := len(cuts)
	dp := make([][]int, n)
	for i := range dp {
		dp[i] = make([]int, n)
	}

	for length := 2; length < n; length++ {
		for i := 0; i < n-length; i++ {
			j := i + length
			dp[i][j] = 1000000000
			for k := i + 1; k < j; k++ {
				dp[i][j] = min(dp[i][j], dp[i][k]+dp[k][j])
			}
			dp[i][j] += cuts[j] - cuts[i]
		}
	}

	return dp[0][n-1]
}

func min(a, b int) int {
	if a < b {
		return a
	}
	return b
}