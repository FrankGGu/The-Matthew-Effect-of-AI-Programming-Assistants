import (
	"math"
)

func minOperations(nums []int) int {
	n := len(nums)
	dp := make([][2]int, n+1)
	for i := 0; i <= n; i++ {
		dp[i][0] = math.MaxInt32
		dp[i][1] = math.MaxInt32
	}
	dp[0][0] = 0
	for i := 1; i <= n; i++ {
		if nums[i-1] == 1 {
			dp[i][1] = min(dp[i-1][1], dp[i-1][0])
			dp[i][0] = dp[i-1][0]
		} else {
			dp[i][0] = min(dp[i-1][0], dp[i-1][1])
			dp[i][1] = min(dp[i-1][0], dp[i-1][1]) + 1
		}
		if i >= 2 {
			if nums[i-1] == 0 && nums[i-2] == 0 {
				dp[i][1] = min(dp[i][1], dp[i-2][0]+1)
			}
		}
	}
	return min(dp[n][0], dp[n][1])
}

func min(a, b int) int {
	if a < b {
		return a
	}
	return b
}