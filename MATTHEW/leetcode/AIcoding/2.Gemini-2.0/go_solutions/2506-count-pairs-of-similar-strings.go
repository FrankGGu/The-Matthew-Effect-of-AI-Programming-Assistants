func similar(s1, s2 string) bool {
	set1 := make(map[rune]bool)
	set2 := make(map[rune]bool)

	for _, r := range s1 {
		set1[r] = true
	}
	for _, r := range s2 {
		set2[r] = true
	}

	if len(set1) != len(set2) {
		return false
	}

	for r := range set1 {
		if !set2[r] {
			return false
		}
	}

	return true
}

func countSimilarPairs(words []string) int {
	count := 0
	for i := 0; i < len(words); i++ {
		for j := i + 1; j < len(words); j++ {
			if similar(words[i], words[j]) {
				count++
			}
		}
	}
	return count
}