package main

func greatestLetter(s string) string {
	seenLower := [26]bool{}
	seenUpper := [26]bool{}

	for i := 0; i < len(s); i++ {
		char := s[i]
		if char >= 'a' && char <= 'z' {
			seenLower[char-'a'] = true
		} else if char >= 'A' && char <= 'Z' {
			seenUpper[char-'A'] = true
		}
	}

	for i := 25; i >= 0; i-- { // Iterate from 'Z' down to 'A'
		if seenLower[i] && seenUpper[i] {
			return string('A' + i)
		}
	}

	return ""
}