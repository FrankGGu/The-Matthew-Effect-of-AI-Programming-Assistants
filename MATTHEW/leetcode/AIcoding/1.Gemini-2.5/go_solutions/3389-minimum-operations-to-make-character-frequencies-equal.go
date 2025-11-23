package main

import "sort"

func minDeletions(s string) int {
	freq := make([]int, 26)
	for _, char := range s {
		freq[char-'a']++
	}

	sort.Slice(freq, func(i, j int) bool {
		return freq[i] > freq[j]
	})

	taken := make(map[int]bool)
	operations := 0

	for _, f := range freq {
		if f == 0 {
			continue
		}
		currentFreq := f
		for taken[currentFreq] {
			currentFreq--
			operations++
			if currentFreq == 0 {
				break
			}
		}
		if currentFreq > 0 {
			taken[currentFreq] = true
		}
	}

	return operations
}