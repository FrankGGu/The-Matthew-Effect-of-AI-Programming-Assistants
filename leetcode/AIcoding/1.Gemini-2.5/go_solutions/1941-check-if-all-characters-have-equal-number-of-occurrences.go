func areOccurrencesEqual(s string) bool {
	counts := make([]int, 26)

	for _, char := range s {
		counts[char-'a']++
	}

	expectedCount := -1

	for _, count := range counts {
		if count > 0 {
			if expectedCount == -1 {
				expectedCount = count
			} else if count != expectedCount {
				return false
			}
		}
	}

	return true
}