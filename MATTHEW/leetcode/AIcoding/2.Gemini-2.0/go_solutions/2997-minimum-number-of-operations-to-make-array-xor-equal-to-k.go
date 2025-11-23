func minOperations(nums []int, k int) int {
	xorSum := 0
	for _, num := range nums {
		xorSum ^= num
	}

	xorResult := xorSum ^ k
	operations := 0
	for xorResult > 0 {
		operations += xorResult & 1
		xorResult >>= 1
	}

	return operations
}