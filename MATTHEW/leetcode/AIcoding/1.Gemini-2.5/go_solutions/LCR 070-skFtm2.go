func singleNonDuplicate(nums []int) int {
	low := 0
	high := len(nums) - 1

	for low < high {
		mid := low + (high-low)/2

		// Ensure mid is even for consistent pair checking (mid, mid+1)
		// If mid is odd, decrement it to