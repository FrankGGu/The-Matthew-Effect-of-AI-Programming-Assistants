func areOccurrencesEqual(s string) bool {
	counts := make(map[rune]int)
	for _, r := range s {
		counts[r]++
	}

	firstCount := -1
	for _, count := range counts {
		if firstCount == -1 {
			firstCount = count
		} else if count != firstCount {
			return false
		}
	}

	return true
}