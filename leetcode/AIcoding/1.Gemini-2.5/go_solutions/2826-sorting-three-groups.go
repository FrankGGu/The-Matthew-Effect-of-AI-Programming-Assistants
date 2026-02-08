import "math"

func minOperations(nums []int) int {
	n := len(nums)
	if n == 0 {
		return 0
	}

	// dp[i][j] represents the maximum number of elements we can keep
	// from nums[0...i-1] such