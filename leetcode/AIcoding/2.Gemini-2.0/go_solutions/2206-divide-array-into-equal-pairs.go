func divideArray(nums []int) bool {
	counts := make(map[int]int)
	for _, num := range nums {
		counts[num]++
	}

	for _, count := range counts {
		if count%2 != 0 {
			return false
		}
	}

	return true
}