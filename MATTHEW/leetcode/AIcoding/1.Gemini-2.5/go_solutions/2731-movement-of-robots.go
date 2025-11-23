func sumDistance(nums []int, s string, d int) int {
	n := len(nums)
	finalPositions := make([]int64, n)

	for i := 0; i < n; i++ {
		pos := int64(nums[i])
		if