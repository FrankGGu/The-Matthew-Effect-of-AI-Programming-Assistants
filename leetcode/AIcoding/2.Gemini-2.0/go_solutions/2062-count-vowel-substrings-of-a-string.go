func countVowelSubstrings(word string) int {
	count := 0
	for i := 0; i < len(word); i++ {
		for j := i; j < len(word); j++ {
			substring := word[i : j+1]
			if isVowelSubstring(substring) {
				count++
			}
		}
	}
	return count
}

func isVowelSubstring(s string) bool {
	vowels := map[rune]bool{'a': true, 'e': true, 'i': true, 'o': true, 'u': true}
	for _, char := range s {
		if !vowels[char] {
			return false
		}
	}

	present := map[rune]bool{'a': false, 'e': false, 'i': false, 'o': false, 'u': false}
	for _, char := range s {
		present[char] = true
	}

	for _, val := range present {
		if !val {
			return false
		}
	}
	return true
}