package main

func findOcurrences(text string, first string, second string) []string {
	var result []string
	words := make([]string, 0)
	for i := 0; i < len(text); i++ {
		if text[i] == ' ' {
			words = append(words, text[:i])
			text = text[i+1:]
			i = -1
		}
	}
	words = append(words, text)

	for i := 0; i < len(words)-2; i++ {
		if words[i] == first && words[i+1] == second {
			result = append(result, words[i+2])
		}
	}
	return result
}