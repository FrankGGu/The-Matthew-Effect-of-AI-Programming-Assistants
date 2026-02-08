package main

import (
	"math"
)

func commonChars(words []string) []string {
	if len(words) == 0 {
		return []string{}
	}

	minFreq := make([]int, 26)
	for i := range minFreq {
		minFreq[i] = math.MaxInt32
	}

	for _, word := range words {
		currentFreq := make([]int, 26)
		for _, char := range word {
			currentFreq[char-'a']++
		}

		for j := 0; j < 26; j++ {
			if currentFreq[j] < minFreq[j] {
				minFreq[j] = currentFreq[j]
			}
		}
	}

	result := []string{}
	for i := 0; i < 26; i++ {
		for k := 0; k < minFreq[i]; k++ {
			result = append(result, string(rune('a'+i)))
		}
	}

	return result
}