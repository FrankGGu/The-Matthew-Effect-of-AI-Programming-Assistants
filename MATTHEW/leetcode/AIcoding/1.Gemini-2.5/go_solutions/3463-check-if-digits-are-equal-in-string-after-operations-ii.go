import "unicode"

func checkDigits(s string) bool {
	firstDigit := rune(0)
	foundFirst := false

	for _, char := range s {
		if unicode.IsDigit(char) {
			if !foundFirst {
				firstDigit = char
				foundFirst = true
			} else {
				if char != firstDigit {
					return false
				}
			}
		}
	}
	return true
}