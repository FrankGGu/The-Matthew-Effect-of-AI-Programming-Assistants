package main

import (
	"strings"
	"unicode"
)

func mostCommonWord(paragraph string, banned []string) string {
	bannedMap := make(map[string]bool)
	for _, word := range banned {
		bannedMap[word] = true
	}

	var sb strings.Builder
	for _, r := range paragraph {
		if unicode.IsLetter(r) {
			sb.WriteRune(unicode.ToLower(r))
		} else {
			sb.WriteRune(' ')
		}
	}

	wordCounts := make(map[string]int)
	words := strings.Fields(sb.String())

	for _, word := range words {
		if _, isBanned := bannedMap[word]; !isBanned {
			wordCounts[word]++
		}
	}

	maxCount := 0
	result := ""
	for word, count := range wordCounts {
		if count > maxCount {
			maxCount = count
			result = word
		}
	}

	return result
}