func numberOfPairs(nums []int) []int {
	count := make(map[int]int)
	for _, num := range nums {
		count[num]++
	}
	pairs := 0
	remaining := 0
	for _, c := range count {
		pairs += c / 2
		remaining += c % 2
	}
	return []int{pairs, remaining}
}