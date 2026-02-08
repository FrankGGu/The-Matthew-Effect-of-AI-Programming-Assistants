import "math"

func longestSubsequence(nums []int, target int) int {
	dp := make([]int, target+1)
	for i := 1; i <= target; i++ {
		dp[i] = -1
	}
	dp[0] = 0

	for _, num :=