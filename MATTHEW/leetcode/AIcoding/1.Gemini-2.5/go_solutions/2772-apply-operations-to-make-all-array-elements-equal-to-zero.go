func solve(n int, k int, nums []int) int {
	// current_active_subtraction stores the cumulative subtraction value
	// that applies to the current index `i` from operations
	// that started within the window `[i-k+1, i]`.
	current_active_subtraction := 0