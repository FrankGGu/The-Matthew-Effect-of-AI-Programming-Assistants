func uniqueMorseRepresentations(words []string) int {
	morseCodes := []string{".-", "-...", "-.-", "-..", ".", "..-.", "--.", "....", "..", ".---", "-.-", ".-..", "--", "-.", "---", ".--.", "--.-", ".-.", "...", "-", "..-", "...-", ".--", "-..-", "-.--", "--.."}
	transformations := make(map[string]bool)
	for _, word := range words {
		transformation := ""
		for _, char := range word {
			transformation += morseCodes[char-'a']
		}
		transformations[transformation] = true
	}
	return len(transformations)
}