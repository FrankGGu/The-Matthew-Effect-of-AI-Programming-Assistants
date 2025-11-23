import (
	"unicode"
)

func solve(s string) string {
	runes := []rune(s)
	newWord := true

	for i := 0; i < len(runes); i++ {
		if unicode.IsLetter(runes[i]) {
			if newWord {
				runes[i] = unicode.ToUpper(runes[i])
				newWord = false
			}
		} else if unicode.IsSpace(runes[i]) {
			newWord = true
		} else {
			newWord = false
		}
	}

	return string(runes)
}