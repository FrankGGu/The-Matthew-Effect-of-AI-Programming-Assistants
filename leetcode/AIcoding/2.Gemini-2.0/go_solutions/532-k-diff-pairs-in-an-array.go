func findPairs(nums []int, k int) int {
	count := 0
	seen := make(map[int]bool)
	freq := make(map[int]int)

	for _, num := range nums {
		freq[num]++
	}

	for num := range freq {
		if k == 0 {
			if freq[num] > 1 && !seen[num] {
				count++
				seen[num] = true
			}
		} else {
			if freq[num+k] > 0 && !seen[num] {
				count++
				seen[num] = true
			}
		}
	}

	return count
}