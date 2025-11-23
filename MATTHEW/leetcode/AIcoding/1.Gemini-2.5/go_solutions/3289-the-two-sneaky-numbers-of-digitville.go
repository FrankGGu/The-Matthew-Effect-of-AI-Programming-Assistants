func findSneakyNumbers(nums []int) []int {
	xorSum := 0
	for _, num := range nums {
		xorSum ^= num
	}

	// Find the rightmost set bit in xorSum.
	// This bit will be 1 in one of the unique numbers and 0 in the other.
	right