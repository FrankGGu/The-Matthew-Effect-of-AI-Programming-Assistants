import (
	"math"
)

func minCostII(costs [][]int, target int) int {
	n := len(costs)
	k := len(costs[0])

	dp := make([][]int, n+1)
	for i := range dp {
		dp[i] = make([]int, target+1)
		for j := range dp[i] {
			dp[i][j] = math.MaxInt32
		}
	}

	dp[0][0] = 0

	for i := 1; i <= n; i++ {
		for j := 1; j <= target; j++ {
			for l := 0; l < k; l++ {
				if j-1 >= 0 && dp[i-1][j-1] != math.MaxInt32 {
					dp[i][j] = min(dp[i][j], dp[i-1][j-1]+costs[i-1][l])
				}
			}
		}
	}

	result := math.MaxInt32
	for l := 0; l < k; l++ {
		dp2 := make([][]int, n+1)
		for i := range dp2 {
			dp2[i] = make([]int, target+1)
			for j := range dp2[i] {
				dp2[i][j] = math.MaxInt32
			}
		}
		dp2[0][0] = 0

		for i := 1; i <= n; i++ {
			for t := 1; t <= target; t++ {
				for color := 0; color < k; color++ {
					if t - 1 >= 0 && dp2[i-1][t-1] != math.MaxInt32 {
						dp2[i][t] = min(dp2[i][t], dp2[i-1][t-1] + costs[i-1][color])
					}
					if color == l && t > 1 && dp2[i-1][t] != math.MaxInt32 {
						dp2[i][t] = min(dp2[i][t], dp2[i-1][t] + costs[i-1][color])
					}
				}
			}
		}

		result = min(result,dp2[n][target])
	}

	if result == math.MaxInt32 {
		return -1
	}

	return result
}

func min(a, b int) int {
	if a < b {
		return a
	}
	return b
}