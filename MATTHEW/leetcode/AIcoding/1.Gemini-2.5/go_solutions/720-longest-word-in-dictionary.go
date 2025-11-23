package main

import (
	"sort"
)

func longestWord(words []string) string {
	sort.Strings(words)

	validWords := make(map[string]bool)
	longest := ""

	for _, word := range words {
		if len(word) == 1 {
			validWords[word] = true
			if len(word) > len(longest) {
				longest = word
			}
		} else {
			prefix := word[:len(word)-1]
			if validWords[prefix] {
				validWords[word] = true
				if len(word) > len(longest) {
					longest = word
				}
			}
		}
	}

	return longest
}