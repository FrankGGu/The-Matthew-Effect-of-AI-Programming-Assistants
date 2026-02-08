func canMakeEqual(words []string) bool {
	count := make(map[rune]int)
	for _, word := range words {
		for _, char := range word {
			count[char]++
		}
	}
	n := len(words)
	for _, c := range count {
		if c%n != 0 {
			return false
		}
	}
	return true
}