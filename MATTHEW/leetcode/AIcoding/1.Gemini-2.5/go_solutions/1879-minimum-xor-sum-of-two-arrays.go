func minimumXORSum(nums1 []int, nums2 []int) int {
	n := len(nums1)
	dp := make([]int, 1<<n)

	// Initialize dp with a large value (infinity)
	for i :=