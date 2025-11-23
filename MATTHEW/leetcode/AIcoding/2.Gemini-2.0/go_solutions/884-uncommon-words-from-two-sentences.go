func uncommonFromSentences(s1 string, s2 string) []string {
	freq := make(map[string]int)
	words1 := strings.Fields(s1)
	words2 := strings.Fields(s2)

	for _, word := range words1 {
		freq[word]++
	}
	for _, word := range words2 {
		freq[word]++
	}

	result := []string{}
	for word, count := range freq {
		if count == 1 {
			result = append(result, word)
		}
	}

	return result
}