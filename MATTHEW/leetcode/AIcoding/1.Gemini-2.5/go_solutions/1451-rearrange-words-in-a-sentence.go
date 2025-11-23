package main

import (
	"sort"
	"strings"
	"unicode"
)

func arrangeWords(text string) string {
	text = strings.ToLower(text)
	words := strings.Fields(text)

	sort.SliceStable(words, func(i, j int) bool {
		return len(words[i]) < len(words[j])
	})

	result := strings.Join(words, " ")

	if len(result) > 0 {
		runes := []rune(result)
		runes[0] = unicode.ToUpper(runes[0])
		result = string(runes)
	}

	return result
}