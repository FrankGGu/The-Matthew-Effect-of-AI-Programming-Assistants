func uniqueOccurrences(arr []int) bool {
	freqMap := make(map[int]int)
	for _, num := range arr {
		freqMap[num]++
	}

	seenFreqs := make(map[int]bool)
	for _, count := range freqMap {
		if seenFreqs[count] {
			return false
		}
		seenFreqs[count] = true
	}

	return true
}