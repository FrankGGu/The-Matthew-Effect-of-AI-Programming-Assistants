package main

import (
	"sort"
)

func findLeastNumOfUniqueInts(arr []int, k int) int {
	freqMap := make(map[int]int)
	for _, num := range arr {
		freqMap[num]++
	}

	frequencies := make([]int, 0, len(freqMap))
	for _, freq := range freqMap {
		frequencies = append(frequencies, freq)
	}

	sort.Ints(frequencies)

	uniqueCount := len(frequencies)

	for _, freq := range frequencies {
		if k >= freq {
			k -= freq
			uniqueCount--
		} else {
			break
		}
	}

	return uniqueCount
}