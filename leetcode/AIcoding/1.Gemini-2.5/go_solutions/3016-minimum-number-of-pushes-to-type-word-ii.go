package main

import (
	"sort"
)

func minimumPushes(word string) int {
	freq := make([]int, 26)
	for _, r := range word {
		freq[r-'a']++
	}

	var nonZeroFreqs []int
	for _, f := range freq {
		if f > 0 {
			nonZeroFreqs = append(nonZeroFreqs, f)
		}
	}

	sort.Slice(nonZeroFreqs, func(i, j int) bool {
		return nonZeroFreqs[i] > nonZeroFreqs[j]
	})

	totalPushes := 0
	for i, f := range nonZeroFreqs {
		pushCost := (i / 9) + 1
		totalPushes += f * pushCost
	}

	return totalPushes
}