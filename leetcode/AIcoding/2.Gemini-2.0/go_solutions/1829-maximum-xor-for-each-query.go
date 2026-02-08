func getMaxXor(nums []int, maximumBit int) []int {
	n := len(nums)
	result := make([]int, n)
	xorSum := 0
	for _, num := range nums {
		xorSum ^= num
	}

	maxVal := (1 << maximumBit) - 1

	for i := 0; i < n; i++ {
		result[i] = maxVal ^ xorSum
		xorSum ^= nums[n-1-i]
	}

	return result
}