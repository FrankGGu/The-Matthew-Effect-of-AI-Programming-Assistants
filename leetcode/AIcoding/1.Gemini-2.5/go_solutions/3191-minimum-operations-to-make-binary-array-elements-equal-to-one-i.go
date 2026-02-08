func minOperations(nums []int) int {
	n := len(nums)
	operations := 0

	for i := 0; i < n; i++ {
		if nums