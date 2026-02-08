func countValidWords(sentence string) int {
	count := 0
	words := strings.Split(sentence, " ")
	for _, word := range words {
		if len(word) == 0 {
			continue
		}
		valid := true
		hyphenCount := 0
		for i, char := range word {
			if unicode.IsDigit(char) {
				valid = false
				break
			}
			if char == '-' {
				hyphenCount++
				if hyphenCount > 1 {
					valid = false
					break
				}
				if i == 0 || i == len(word)-1 {
					valid = false
					break
				}
				if !unicode.IsLetter(rune(word[i-1])) || !unicode.IsLetter(rune(word[i+1])) {
					valid = false
					break
				}
			}
			if char == '!' || char == '.' || char == ',' {
				if i != len(word)-1 {
					valid = false
					break
				}
			}
		}
		if valid {
			count++
		}
	}
	return count
}