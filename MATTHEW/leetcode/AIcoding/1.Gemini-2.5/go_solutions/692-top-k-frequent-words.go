package main

import (
	"sort"
)

func topKFrequent(words []string, k int) []string {
	freqMap := make(map[string]int)
	for _, word := range words {
		freqMap[word]++
	}

	uniqueWords := make([]string, 0, len(freqMap))
	for word := range freqMap {
		uniqueWords = append(uniqueWords, word)
	}

	sort.Slice(uniqueWords, func(i, j int) bool {
		word1 := uniqueWords[i]
		word2 := uniqueWords[j]

		freq1 := freqMap[word1]
		freq2 := freqMap[word2]

		if freq1 != freq2 {
			return freq1 > freq2
		}
		return word1 < word2
	})

	return uniqueWords[:k]
}