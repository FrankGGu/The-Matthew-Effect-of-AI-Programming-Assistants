func findXSumOfAllKLongSubarraysI(nums []int, k int) []int {
	n := len(nums)

	// Handle edge cases where no valid subarrays can be formed.
	// If k is non-positive, or k is greater than the array length,
	// there are no k-long subarrays.
	if