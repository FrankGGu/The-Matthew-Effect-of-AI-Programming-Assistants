func longestStrChain(words []string) int {
	wordSet := make(map[string]bool)
	for _, word := range words {
		wordSet[word] = true
	}

	dp := make(map[string]int)
	maxLen := 0

	var dfs func(word string) int
	dfs = func(word string) int {
		if len(word) == 0 {
			return 0
		}
		if val, ok := dp[word]; ok {
			return val
		}

		maxChain := 1
		for i := 0; i < len(word); i++ {
			newWord := word[:i] + word[i+1:]
			if wordSet[newWord] {
				chainLen := dfs(newWord) + 1
				if chainLen > maxChain {
					maxChain = chainLen
				}
			}
		}

		dp[word] = maxChain
		return maxChain
	}

	for _, word := range words {
		len := dfs(word)
		if len > maxLen {
			maxLen = len
		}
	}

	return maxLen
}