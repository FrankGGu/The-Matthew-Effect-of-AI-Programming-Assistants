func zeroArray(nums []int) int {
	n := len(nums)
	operations := 0

	for i := 0; i < n; i++ {
		// If nums[i] is negative, it means a previous operation made it negative,
		// which is impossible to correct and indicates an invalid state