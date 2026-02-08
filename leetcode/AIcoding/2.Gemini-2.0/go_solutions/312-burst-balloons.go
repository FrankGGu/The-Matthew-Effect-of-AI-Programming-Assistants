import "fmt"

func maxCoins(nums []int) int {
	n := len(nums)
	nums = append([]int{1}, nums...)
	nums = append(nums, 1)

	dp := make([][]int, n+2)
	for i := range dp {
		dp[i] = make([]int, n+2)
	}

	for len := 2; len <= n+1; len++ {
		for i := 0; i <= n+1-len; i++ {
			j := i + len
			for k := i + 1; k < j; k++ {
				dp[i][j] = max(dp[i][j], dp[i][k]+nums[i]*nums[k]*nums[j]+dp[k][j])
			}
		}
	}

	return dp[0][n+1]
}

func max(a, b int) int {
	if a > b {
		return a
	}
	return b
}