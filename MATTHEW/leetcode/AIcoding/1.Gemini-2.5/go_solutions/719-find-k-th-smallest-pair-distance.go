func smallestDistancePair(nums []int, k int) int {
	sort.Ints(nums)
	n := len(nums)

	// The possible range for the k-th smallest distance.
	// Minimum distance is 0.
	// Maximum distance is nums[n-1]