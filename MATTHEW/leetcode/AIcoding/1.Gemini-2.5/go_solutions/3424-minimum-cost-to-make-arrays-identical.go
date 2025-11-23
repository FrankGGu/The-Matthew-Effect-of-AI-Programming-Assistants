func minCost(nums []int, costs []int) int64 {
	n := len(nums)

	// Create pairs of (nums[i], costs[i])
	type pair struct {
		num  int
		cost int
	}