package main

func sortSentence(s string) string {
	words := make([]string, 0)
	currentWord := ""
	for _, c := range s {
		if c == ' ' {
			words = append(words, currentWord)
			currentWord = ""
		} else {
			currentWord += string(c)
		}
	}
	words = append(words, currentWord)

	result := make([]string, len(words))
	for _, word := range words {
		idx := int(word[len(word)-1] - '0')
		result[idx-1] = word[:len(word)-1]
	}

	return strings.Join(result, " ")
}