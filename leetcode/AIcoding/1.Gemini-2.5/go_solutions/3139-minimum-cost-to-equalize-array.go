func minCostToEqualizeArray(nums []int, cost1 int, cost2 int) int64 {
	n := len(nums)
	if n == 0 {
		return 0
	}

	minVal := nums[0