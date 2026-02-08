func uniqueMorseRepresentations(words []string) int {
	morseCodes := []string{
		".-", "-...", "-.-.", "-..", ".", "..-.", "--.", "....", "..", ".---", "-.-", ".-..", "--", "-.", "---", ".--.", "--.-", ".-.", "...", "-", "..-", "...-", ".--", "-..-", "-.--", "--..",
	}

	uniqueTransformations := make(map[string]bool)

	for _, word := range words {
		var builder strings.Builder
		for _, char := range word {
			// Convert character to its 0-indexed position in the alphabet
			// 'a' corresponds to index 0, 'b' to index 1, etc.
			builder.WriteString(morseCodes[char-'a'])
		}
		uniqueTransformations[builder.String()] = true
	}

	return len(uniqueTransformations)
}