func minSpaceWasted(nums []int, k int) int {
	n := len(nums)

	// If k is large enough to make each element its own segment, wasted space is 0.
	// A segment of length 1 has (max_val * 1)