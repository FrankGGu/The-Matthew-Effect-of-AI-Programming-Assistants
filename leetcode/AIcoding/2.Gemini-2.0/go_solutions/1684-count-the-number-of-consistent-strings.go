func countConsistentStrings(allowed string, words []string) int {
	allowedSet := make(map[rune]bool)
	for _, char := range allowed {
		allowedSet[char] = true
	}

	count := 0
	for _, word := range words {
		consistent := true
		for _, char := range word {
			if !allowedSet[char] {
				consistent = false
				break
			}
		}
		if consistent {
			count++
		}
	}

	return count
}