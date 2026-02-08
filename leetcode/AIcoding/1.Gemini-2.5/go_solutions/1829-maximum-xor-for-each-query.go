func getMaximumXor(nums []int, maximumBit int) []int {
	n := len(nums)
	result := make([]int, n)

	currentXORsum := 0
	for _, num := range nums {
		currentXORsum ^= num
	}

	// The mask represents