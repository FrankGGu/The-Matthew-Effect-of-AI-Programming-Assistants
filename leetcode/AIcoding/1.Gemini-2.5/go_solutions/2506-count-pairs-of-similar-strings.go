func similarPairs(words []string) int {
	maskCounts := make(map[int]int)

	for _, word := range words {
		mask := 0
		for _, char := range word {
			mask |= (1 << (char - 'a'))
		}
		maskCounts[mask]++
	}

	totalPairs := 0
	for _, count := range maskCounts {
		if count >= 2 {
			totalPairs += count * (count - 1) / 2
		}
	}

	return totalPairs
}