package main

import (
	"strings"
)

func replaceWords(dict []string, sentence string) string {
	trie := make(map[string]bool)
	for _, root := range dict {
		trie[root] = true
	}

	words := strings.Fields(sentence)
	for i, word := range words {
		for j := 1; j <= len(word); j++ {
			if trie[word[:j]] {
				words[i] = word[:j]
				break
			}
		}
	}
	return strings.Join(words, " ")
}