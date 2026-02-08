func smallestRangeII(nums []int, k int) int {
	n := len(nums)
	if n <= 1 {
		return 0
	}

	sort.Ints(nums)

	// Initial answer is the range when all elements are modified in the