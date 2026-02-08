import (
	"strings"
)

func countValidWords(sentence string) int {
	words := strings.Fields(sentence)
	count := 0

	for _, word := range words {
		if isValidWord(word) {
			count++
		}
	}
	return count
}

func isValidWord(word string) bool {
	if len(word) == 0 {
		return false
	}

	hyphenCount := 0
	hasPunctuation := false

	for i := 0; i < len(word); i++ {
		ch := word[i]

		if ch >= '0' && ch <= '9' {
			return false // Contains a digit
		}

		if ch == '-' {
			hyphenCount++
			if hyphenCount > 1 {
				return false // More than one hyphen
			}
			if i == 0 || i == len(word)-1 {
				return false // Hyphen at start or end
			}
			// Hyphen must be surrounded by lowercase letters
			if !isLower(word[i-1]) || !isLower(word[i+1]) {
				return false
			}
		} else if ch == '.' || ch == '!' || ch == ',' {
			if hasPunctuation {
				return false // More than one punctuation
			}
			hasPunctuation = true
			if i != len(word)-1 {
				return false // Punctuation not at the end
			}
		} else {
			// Must be a lowercase letter
			if !isLower(ch) {
				return false // Contains an invalid character (e.g., uppercase, other symbol)
			}
		}
	}

	return true
}

func isLower(ch byte) bool {
	return ch >= 'a' && ch <= 'z'
}