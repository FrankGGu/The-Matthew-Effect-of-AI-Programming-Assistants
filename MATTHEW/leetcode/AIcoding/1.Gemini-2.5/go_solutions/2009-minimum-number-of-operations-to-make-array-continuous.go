func minOperations(nums []int) int {
	n := len(nums)

	// Step 1: Remove duplicates and sort the unique elements
	sort.Ints(nums)

	uniqueNums := make([]int, 0, n)
	if n > 0 {