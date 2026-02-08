import "unicode"

func detectCapitalUse(word string) bool {
	n := len(word)
	if n == 0 {
		return true
	}

	upperCount := 0
	for _, char := range word {
		if unicode.IsUpper(char) {
			upperCount++
		}
	}

	if upperCount == n {
		return true
	}

	if upperCount == 0 {
		return true
	}

	if upperCount == 1 && unicode.IsUpper(rune(word[0])) {
		return true
	}

	return false
}