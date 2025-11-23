import "math"

func minimumOperations(nums []int) int {
	n := len(nums)
	dp := make([][]int, n+1)
	for i := 0; i <= n; i++ {
		dp[i] = make([]int, 4)
		for j := 0; j < 4; j++ {
			dp[i][j] = math.MaxInt32
		}
	}
	dp[0][0] = 0

	for i := 1; i <= n; i++ {
		for j := 1; j <= 3; j++ {
			for k := 0; k < j; k++ {
				if nums[i-1] == j {
					dp[i][j] = min(dp[i][j], dp[i-1][j])
					dp[i][j] = min(dp[i][j], dp[i-1][k])
				} else {
					dp[i][j] = min(dp[i][j], dp[i-1][j]+1)
					dp[i][j] = min(dp[i][j], dp[i-1][k]+1)
				}
			}
		}
	}

	ans := math.MaxInt32
	for i := 1; i <= 3; i++ {
		ans = min(ans, dp[n][i])
	}
	return ans
}

func min(a, b int) int {
	if a < b {
		return a
	}
	return b
}