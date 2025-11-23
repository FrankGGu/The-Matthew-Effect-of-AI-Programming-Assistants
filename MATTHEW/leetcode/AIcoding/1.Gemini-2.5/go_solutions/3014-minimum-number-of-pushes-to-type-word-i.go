package main

import (
	"sort"
)

func minimumPushes(word string) int {
	freq := make(map[rune]int)
	for _, char := range word {
		freq[char]++
	}

	var freqs []int
	for _, count := range freq {
		freqs = append(freqs, count)
	}

	sort.Slice(freqs, func(i, j int) bool {
		return freqs[i] > freqs[j]
	})

	totalPushes := 0
	for i, count := range freqs {
		pushesPerChar := (i / 8) + 1
		totalPushes += count * pushesPerChar
	}

	return totalPushes
}