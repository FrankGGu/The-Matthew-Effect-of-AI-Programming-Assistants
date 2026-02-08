import (
	"math"
)

func minDifficulty(jobDifficulty []int, d int) int {
	n := len(jobDifficulty)
	if n < d {
		return -1
	}

	dp := make([][]int, d+1)
	for i := range dp {
		dp[i] = make([]int, n+1)
		for j := range dp[i] {
			dp[i][j] = math.MaxInt32
		}
	}

	dp[0][0] = 0

	for i := 1; i <= d; i++ {
		for j := i; j <= n; j++ {
			maxDifficulty := 0
			for k := j; k >= i; k-- {
				maxDifficulty = max(maxDifficulty, jobDifficulty[k-1])
				if dp[i-1][k-1] != math.MaxInt32 {
					dp[i][j] = min(dp[i][j], dp[i-1][k-1] + maxDifficulty)
				}
			}
		}
	}

	if dp[d][n] == math.MaxInt32 {
		return -1
	}

	return dp[d][n]
}

func max(a, b int) int {
	if a > b {
		return a
	}
	return b
}

func min(a, b int) int {
	if a < b {
		return a
	}
	return b
}