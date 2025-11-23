func numIdenticalPairs(nums []int) int {
	counts := make(map[int]int)
	for _, num := range nums {
		counts[num]++
	}

	goodPairs := 0
	for _, count := range counts {
		if count > 1 {
			goodPairs += count * (count - 1) / 2
		}
	}

	return goodPairs
}