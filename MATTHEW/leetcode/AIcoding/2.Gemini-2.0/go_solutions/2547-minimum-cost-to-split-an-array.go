import (
	"math"
)

func minCost(nums []int, k int) int {
	n := len(nums)
	dp := make([]int, n+1)
	for i := 1; i <= n; i++ {
		dp[i] = math.MaxInt32
	}

	for i := 1; i <= n; i++ {
		for j := 1; j <= i; j++ {
			cost := k + calculateCost(nums, i-j, i-1)
			dp[i] = min(dp[i], dp[i-j]+cost)
		}
	}

	return dp[n]
}

func calculateCost(nums []int, left, right int) int {
	count := make(map[int]int)
	trim := 0
	for i := left; i <= right; i++ {
		count[nums[i]]++
		if count[nums[i]] > 1 {
			trim++
		}
	}
	return trim
}

func min(a, b int) int {
	if a < b {
		return a
	}
	return b
}