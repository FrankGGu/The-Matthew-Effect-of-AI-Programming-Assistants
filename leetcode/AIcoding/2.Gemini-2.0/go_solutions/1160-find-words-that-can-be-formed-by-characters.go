func countCharacters(words []string, chars string) int {
	count := 0
	charCounts := make(map[rune]int)
	for _, char := range chars {
		charCounts[char]++
	}

	for _, word := range words {
		wordCounts := make(map[rune]int)
		good := true
		for _, char := range word {
			wordCounts[char]++
			if wordCounts[char] > charCounts[char] {
				good = false
				break
			}
		}
		if good {
			count += len(word)
		}
	}
	return count
}