import "strings"

func minimumLengthEncoding(words []string) int {
	wordSet := make(map[string]struct{})
	for _, word := range words {
		wordSet[word] = struct{}{}
	}

	for _, word := range words {
		// For each word, generate its suffixes (excluding the word itself)