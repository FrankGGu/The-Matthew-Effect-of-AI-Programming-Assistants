package main

func findWords(words []string) []string {
	keyboard := [3]string{"qwertyuiop", "asdfghjkl", "zxcvbnm"}
	result := []string{}

	for _, word := range words {
		found := false
		for _, row := range keyboard {
			if containsAll(word, row) {
				result = append(result, word)
				found = true
				break
			}
		}
	}

	return result
}

func containsAll(word string, row string) bool {
	for _, c := range word {
		if !contains(rune(row), c) {
			return false
		}
	}
	return true
}

func contains(s string, c rune) bool {
	for _, ch := range s {
		if ch == c {
			return true
		}
	}
	return false
}