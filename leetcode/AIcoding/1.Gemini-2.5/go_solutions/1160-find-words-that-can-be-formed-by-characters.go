func countCharacters(words []string, chars string) int {
	charCounts := make([]int, 26)
	for _, r := range chars {
		charCounts[r-'a']++
	}

	totalLength := 0
	for _, word := range words {
		wordCounts := make([]int, 26)
		for _, r := range word {
			wordCounts[r-'a']++
		}

		canForm := true
		for i := 0; i < 26; i++ {
			if wordCounts[i] > charCounts[i] {
				canForm = false
				break
			}
		}

		if canForm {
			totalLength += len(word)
		}
	}

	return totalLength
}