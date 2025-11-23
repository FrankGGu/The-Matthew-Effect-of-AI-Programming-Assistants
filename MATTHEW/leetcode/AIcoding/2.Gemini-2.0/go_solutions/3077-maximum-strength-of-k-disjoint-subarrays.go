import (
	"math"
)

func maxStrength(nums []int, k int) int64 {
	n := len(nums)
	dp := make([][]int64, n+1)
	for i := 0; i <= n; i++ {
		dp[i] = make([]int64, k+1)
		for j := 0; j <= k; j++ {
			dp[i][j] = math.MinInt64
		}
	}
	dp[0][0] = 1

	for i := 1; i <= n; i++ {
		for j := 0; j <= k; j++ {
			dp[i][j] = dp[i-1][j]
			if j > 0 {
				prod := int64(nums[i-1])
				dp[i][j] = max(dp[i][j], dp[i-1][j-1]*prod)
			}
		}
	}

	return dp[n][k]
}

func max(a, b int64) int64 {
	if a > b {
		return a
	}
	return b
}