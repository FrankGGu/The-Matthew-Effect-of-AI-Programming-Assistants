package main

import "strings"

func findOcurrences(text string, first string, second string) []string {
	words := strings.Fields(text)
	var result []string

	for i := 0; i < len(words)-2; i++ {
		if words[i] == first && words[i+1] == second {
			result = append(result, words[i+2])
		}
	}

	return result
}