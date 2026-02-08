func sortString(s string) string {
	freq := [26]int{}
	for _, char := range s {
		freq[char-'a']++
	}

	var result strings.Builder
	result.Grow(len(s)) // Pre-allocate capacity for efficiency

	for result.Len() < len(s) {
		// Pass 1: Smallest to largest character
		for i := 0; i < 26; i++ {
			if freq[i] > 0 {
				result.WriteRune(rune('a' + i))
				freq[i]--
			}
		}

		// Pass 2: Largest to smallest character
		for i := 25; i >= 0; i-- {
			if freq[i] > 0 {
				result.WriteRune(rune('a' + i))
				freq[i]--
			}
		}
	}

	return result.String()
}