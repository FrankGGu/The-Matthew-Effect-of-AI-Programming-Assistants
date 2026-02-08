func canSortArray(nums []int) bool {
	n := len(nums)
	if n <= 1 {
		return true
	}

	for i := 0; i < n; {
		// Find the start of a