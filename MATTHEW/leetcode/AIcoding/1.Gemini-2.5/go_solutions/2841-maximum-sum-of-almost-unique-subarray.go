func max(a, b int64) int64 {
	if a > b {
		return a
	}
	return b
}

func maximumSubarraySum(nums []int, m int, k int) int64 {
	var maxSum int64 = 0
	var currentSum int64