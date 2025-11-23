func longestPalindrome(words []string) int {
	counts := make(map[string]int)
	for _, word := range words {
		counts[word]++
	}

	ans := 0
	hasCenter := false

	for word, count :=