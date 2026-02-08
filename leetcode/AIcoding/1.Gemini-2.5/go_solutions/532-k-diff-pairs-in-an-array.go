func findPairs(nums []int, k int) int {
	if k < 0 {
		return 0
	}

	if k == 0 {
		freqMap := make(map[int]int)
		for _, num := range nums {
			freqMap[num]++
		}

		count := 0
		for _, freq := range freqMap {
			if freq >= 2 {
				count++
			}
		}
		return count
	}

	// k > 0
	seen := make(map[int]bool)
	for _, num := range nums {
		seen[num] = true
	}

	count := 0
	for num := range seen {
		if seen[num+k] {
			count++
		}
	}
	return count
}