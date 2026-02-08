func checkDistances(s string, distance []int) bool {
	firstOccurrences := [26]int{}
	for i := 0; i < 26; i++ {
		firstOccurrences[i] = -1
	}

	for i, r := range s {
		charIdx := r - 'a'
		if firstOccurrences[charIdx] == -1 {
			firstOccurrences[charIdx] = i
		} else {
			actualDistance := i - firstOccurrences[charIdx] - 1
			if actualDistance != distance[charIdx] {
				return false
			}
		}
	}

	return true
}