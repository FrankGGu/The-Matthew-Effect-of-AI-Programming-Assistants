func findAllConcatenatedWordsInADict(words []string) []string {
	wordSet := make(map[string]bool)
	for _, word := range words {
		wordSet[word] = true
	}

	var result []string
	for _, word := range words {
		if canForm(word, wordSet) {
			result = append(result, word)
		}
	}

	return result
}

func canForm(word string, wordSet map[string]bool) bool {
	n := len(word)
	dp := make([]bool, n+1)
	dp[0] = true

	for i := 1; i <= n; i++ {
		for j := 0; j < i; j++ {
			sub := word[j:i]
			if dp[j] && wordSet[sub] && sub != word {
				dp[i] = true
				break
			}
		}
	}

	return dp[n]
}