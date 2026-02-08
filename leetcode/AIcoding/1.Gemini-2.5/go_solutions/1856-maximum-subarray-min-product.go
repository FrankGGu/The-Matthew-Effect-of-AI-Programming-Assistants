func maxSumMinProduct(nums []int) int {
	n := len(nums)

	// Step 1: Compute prefix sums
	prefixSum := make([]int64, n+1)
	for i := 0; i < n; i++ {
		prefix