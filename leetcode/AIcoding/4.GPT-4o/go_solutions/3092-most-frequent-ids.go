package main

import (
	"sort"
)

func mostFrequentID(ids []int) []int {
	count := make(map[int]int)
	for _, id := range ids {
		count[id]++
	}

	maxFreq := 0
	for _, freq := range count {
		if freq > maxFreq {
			maxFreq = freq
		}
	}

	result := []int{}
	for id, freq := range count {
		if freq == maxFreq {
			result = append(result, id)
		}
	}

	sort.Ints(result)
	return result
}