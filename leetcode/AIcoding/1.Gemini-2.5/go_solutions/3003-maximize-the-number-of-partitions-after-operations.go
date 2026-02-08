package main

import (
	"math"
)

func max(a, b int) int {
	if a > b {
		return a
	}
	return b
}

func maximizeTheNumberOfPartitions(s string) int {
	n := len(s)
	if n == 0 {
		return 0
	}

	prefixResets := make([]int, n+1)
	prefixMasks := make([]int, n+1)
	currentMask := 0
	currentResets := 0
	for i := 0; i < n; i++ {
		charBit := 1 << (s[i] - 'a')
		if (currentMask & charBit) != 0 {
			currentResets++
			currentMask = 0
		}
		currentMask |= charBit
		prefixResets[i+1] = currentResets
		prefixMasks[i+1] = currentMask
	}

	suffixResets := make([]int, n+1)
	suffixMasks := make([]int, n+1)
	currentMask = 0
	currentResets = 0
	for i := n - 1; i >= 0; i-- {
		charBit := 1 << (s[i] - 'a')
		if (currentMask & charBit) != 0 {
			currentResets++
			currentMask = 0
		}
		currentMask |= charBit
		suffixResets[i] = currentResets
		suffixMasks[i] = currentMask
	}

	maxPartitions := prefixResets[n] + 1

	for idx := 0; idx < n; idx++ {
		for charCode := 0; charCode < 26; charCode++ {
			tempResets := prefixResets[idx]
			tempMask := prefixMasks[idx]

			newCharBit := 1 << charCode

			if (tempMask & newCharBit) != 0 {
				tempResets++
				tempMask = 0
			}
			tempMask |= newCharBit

			if idx+1 < n {
				if (tempMask & suffixMasks[idx+1]) != 0 {
					tempResets++
					tempResets += suffixResets[idx+1]
				} else {
					tempResets += suffixResets[idx+1]
				}
			}
			maxPartitions = max(maxPartitions, tempResets+1)
		}
	}

	return maxPartitions
}