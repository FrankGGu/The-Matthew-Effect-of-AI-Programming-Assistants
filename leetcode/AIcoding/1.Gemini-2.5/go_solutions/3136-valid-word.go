func isValid(word string) bool {
	if len(word) < 3 {
		return false
	}

	hasVowel := false
	hasConsonant := false

	for _, r := range word {
		if !unicode.IsLetter(r) && !unicode.IsDigit(r) {
			return false
		}

		if unicode.IsLetter(r) {
			lowerR := unicode.ToLower(r)
			if lowerR == 'a' || lowerR == 'e' || lowerR == 'i' || lowerR == 'o' || lowerR == 'u' {
				hasVowel = true
			} else {
				hasConsonant = true
			}
		}
	}

	return hasVowel && hasConsonant
}