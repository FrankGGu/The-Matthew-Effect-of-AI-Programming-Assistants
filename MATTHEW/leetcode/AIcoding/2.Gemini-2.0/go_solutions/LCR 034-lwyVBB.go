func isAlienSorted(words []string, order string) bool {
	orderMap := make(map[rune]int)
	for i, c := range order {
		orderMap[c] = i
	}

	for i := 0; i < len(words)-1; i++ {
		word1 := words[i]
		word2 := words[i+1]
		minLen := min(len(word1), len(word2))

		for j := 0; j < minLen; j++ {
			char1 := rune(word1[j])
			char2 := rune(word2[j])

			if orderMap[char1] < orderMap[char2] {
				goto NextWord
			} else if orderMap[char1] > orderMap[char2] {
				return false
			}
		}

		if len(word1) > len(word2) {
			return false
		}

	NextWord:
	}

	return true
}

func min(a, b int) int {
	if a < b {
		return a
	}
	return b
}