func advantageCount(nums1 []int, nums2 []int) []int {
	n := len(nums1)
	ans := make([]int, n)

	// Create pairs of (value, original_index) for nums2
	type pair struct {
		val   int
		index int