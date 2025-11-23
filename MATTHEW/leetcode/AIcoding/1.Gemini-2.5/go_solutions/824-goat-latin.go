func isVowel(r rune) bool {
	lowerR := unicode.ToLower(r)
	return lowerR == 'a' || lowerR == 'e' || lowerR == 'i' || lowerR == 'o' || lowerR == 'u'
}

func toGoatLatin(sentence string) string {
	words := strings.Fields(sentence) // Splits the sentence into words, handling multiple spaces.
	resultWords := make([]string, len(words))

	for i, word := range words {
		var transformedWord string

		// Rule 1 & 2: Handle vowel/consonant start
		if isVowel(rune(word[0])) {
			transformedWord = word + "ma"
		} else {
			transformedWord = word[1:] + string(word[0]) + "ma"
		}

		// Rule 3: Add 'a's based on word index
		transformedWord += strings.Repeat("a", i+1)
		resultWords[i] = transformedWord
	}

	return strings.Join(resultWords, " ")
}