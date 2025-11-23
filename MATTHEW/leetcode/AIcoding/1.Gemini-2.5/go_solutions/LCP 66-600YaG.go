package main

import (
	"math"
)

func minBooths(words []string) int {
	maxFreq := make([]int, 26)

	for _, word := range words {
		currentWordFreq := make([]int, 26)
		for _, char := range word {
			currentWordFreq[char-'a']++
		}

		for i := 0; i < 26; i++ {
			maxFreq[i] = int(math.Max(float64(maxFreq[i]), float64(currentWordFreq[i])))
		}
	}

	totalBooths := 0
	for _, count := range maxFreq {
		totalBooths += count
	}

	return totalBooths
}