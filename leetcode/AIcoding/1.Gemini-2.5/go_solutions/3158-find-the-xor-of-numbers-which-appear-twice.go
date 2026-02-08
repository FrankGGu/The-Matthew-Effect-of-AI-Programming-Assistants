func duplicateNumbersXOR(nums []int) int {
	counts := make(map[int]int)
	for _, num := range nums {
		counts[num]++
	}

	xorSum := 0
	for num, count := range counts {
		if count == 2 {
			xorSum ^= num
		}
	}

	return xorSum
}