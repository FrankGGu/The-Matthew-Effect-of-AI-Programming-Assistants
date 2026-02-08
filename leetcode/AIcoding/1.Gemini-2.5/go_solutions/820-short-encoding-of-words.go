package main

func minimumLengthEncoding(words []string) int {
	wordSet := make(map[string]bool)
	for _, word := range words {
		wordSet[word] = true
	}

	for _, word := range words {
		for i := 1; i < len(word); i++ {
			suffix := word[i:]
			if wordSet[suffix] {
				delete(wordSet, suffix)
			}
		}
	}

	totalLength := 0
	for word := range wordSet {
		totalLength += len(word) + 1
	}

	return totalLength
}