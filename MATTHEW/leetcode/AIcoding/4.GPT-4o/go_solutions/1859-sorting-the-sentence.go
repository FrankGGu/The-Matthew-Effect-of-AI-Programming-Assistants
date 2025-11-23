func sortSentence(s string) string {
	words := strings.Split(s, " ")
	n := len(words)
	sortedWords := make([]string, n)

	for _, word := range words {
		index := int(word[len(word)-1] - '0') - 1
		sortedWords[index] = word[:len(word)-1]
	}

	return strings.Join(sortedWords, " ")
}