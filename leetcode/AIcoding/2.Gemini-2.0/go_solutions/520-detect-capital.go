import "unicode"

func detectCapitalUse(word string) bool {
	n := len(word)
	if n == 0 {
		return true
	}

	firstCapital := unicode.IsUpper(rune(word[0]))
	allCapital := true
	allLower := true
	restLower := true

	for i := 0; i < n; i++ {
		if !unicode.IsUpper(rune(word[i])) {
			allCapital = false
		}
		if !unicode.IsLower(rune(word[i])) {
			allLower = false
		}
		if i > 0 && !unicode.IsLower(rune(word[i])) {
			restLower = false
		}
	}

	if allCapital || allLower {
		return true
	}

	if firstCapital && restLower {
		return true
	}

	return false
}