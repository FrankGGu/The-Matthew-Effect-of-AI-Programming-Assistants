package main

func countWords(words1 []string, words2 []string) int {
	freq1 := make(map[string]int)
	for _, word := range words1 {
		freq1[word]++
	}

	freq2 := make(map[string]int)
	for _, word := range words2 {
		freq2[word]++
	}

	count := 0
	for word, c1 := range freq1 {
		if c1 == 1 {
			if c2, ok := freq2[word]; ok && c2 == 1 {
				count++
			}
		}
	}

	return count
}