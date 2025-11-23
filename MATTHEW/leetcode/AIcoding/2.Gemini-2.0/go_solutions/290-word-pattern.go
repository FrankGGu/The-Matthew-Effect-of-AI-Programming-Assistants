import (
	"strings"
)

func wordPattern(pattern string, s string) bool {
	words := strings.Split(s, " ")
	if len(pattern) != len(words) {
		return false
	}

	patternToWord := make(map[rune]string)
	wordToPattern := make(map[string]rune)

	for i := 0; i < len(pattern); i++ {
		char := rune(pattern[i])
		word := words[i]

		if val, ok := patternToWord[char]; ok {
			if val != word {
				return false
			}
		} else {
			if _, ok := wordToPattern[word]; ok {
				return false
			}
			patternToWord[char] = word
			wordToPattern[word] = char
		}
	}

	return true
}