import (
	"strings"
)

func reformat(s string) string {
	digits := strings.Builder{}
	letters := strings.Builder{}

	for _, char := range s {
		if char >= '0' && char <= '9' {
			digits.WriteRune(char)
		} else {
			letters.WriteRune(char)
		}
	}

	digitsStr := digits.String()
	lettersStr := letters.String()

	lenDigits := len(digitsStr)
	lenLetters := len(lettersStr)

	if abs(lenDigits-lenLetters) > 1 {
		return ""
	}

	var result strings.Builder

	if lenDigits > lenLetters {
		for i := 0; i < lenLetters; i++ {
			result.WriteString(string(digitsStr[i]))
			result.WriteString(string(lettersStr[i]))
		}
		result.WriteString(string(digitsStr[lenLetters]))
	} else if lenLetters > lenDigits {
		for i := 0; i < lenDigits; i++ {
			result.WriteString(string(lettersStr[i]))
			result.WriteString(string(digitsStr[i]))
		}
		result.WriteString(string(lettersStr[lenDigits]))
	} else {
		for i := 0; i < lenDigits; i++ {
			result.WriteString(string(digitsStr[i]))
			result.WriteString(string(lettersStr[i]))
		}
	}

	return result.String()
}

func abs(x int) int {
	if x < 0 {
		return -x
	}
	return x
}