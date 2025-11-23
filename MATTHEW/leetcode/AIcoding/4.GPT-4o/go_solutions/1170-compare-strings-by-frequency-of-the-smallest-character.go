package main

import (
	"sort"
	"strings"
)

func frequency(s string) int {
	counts := make([]int, 26)
	for _, ch := range s {
		counts[ch-'a']++
	}
	for i := 0; i < 26; i++ {
		if counts[i] > 0 {
			return counts[i]
		}
	}
	return 0
}

func areEqual(word1 string, word2 string) bool {
	return frequency(word1) == frequency(word2)
}

func numSmallerByFrequency(queries []string, words []string) []int {
	wordFreq := make([]int, len(words))
	for i, w := range words {
		wordFreq[i] = frequency(w)
	}
	sort.Ints(wordFreq)

	result := make([]int, len(queries))
	for i, q := range queries {
		freq := frequency(q)
		result[i] = len(wordFreq) - sort.Search(len(wordFreq), func(i int) bool {
			return wordFreq[i] <= freq
		})
	}
	return result
}