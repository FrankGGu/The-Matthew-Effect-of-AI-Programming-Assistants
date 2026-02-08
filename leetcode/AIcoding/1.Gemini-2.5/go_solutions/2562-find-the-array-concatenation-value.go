func findTheArrayConcVal(nums []int) int64 {
	var concVal int64 = 0
	left := 0
	right := len(nums) - 1

	for left <= right {
		if left == right {
			// Only one element left
			conc