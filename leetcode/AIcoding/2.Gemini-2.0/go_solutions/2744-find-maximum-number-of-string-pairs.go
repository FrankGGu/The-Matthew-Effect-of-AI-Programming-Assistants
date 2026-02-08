func maximumNumberOfStringPairs(words []string) int {
	count := 0
	seen := make(map[string]bool)
	for i := 0; i < len(words); i++ {
		reversed := reverseString(words[i])
		if seen[reversed] {
			count++
		}
		seen[words[i]] = true
	}
	return count
}

func reverseString(s string) string {
	runes := []rune(s)
	for i, j := 0, len(runes)-1; i < j; i, j = i+1, j-1 {
		runes[i], runes[j] = runes[j], runes[i]
	}
	return string(runes)
}