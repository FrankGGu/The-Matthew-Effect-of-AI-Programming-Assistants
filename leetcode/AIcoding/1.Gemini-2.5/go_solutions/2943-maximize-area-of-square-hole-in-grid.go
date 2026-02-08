package main

import (
	"sort"
)

func getMaxConsecutive(bars []int) int {
	if len(bars) == 0 {
		return 0
	}

	sort.Ints(bars)

	maxLen := 1
	currentLen := 1

	for i := 1; i < len(bars); i++ {
		if bars[i] == bars[i-1]+1 {
			currentLen++
		} else {
			currentLen = 1
		}
		if currentLen > maxLen {
			maxLen = currentLen
		}
	}
	return maxLen
}

func maxArea(n int, m int, hBars []int, vBars []int) int {
	max_k_h := getMaxConsecutive(hBars)
	max_k_v := getMaxConsecutive(vBars)

	max_side := 0
	if max_k_h < max_k_v {
		max_side = max_k_h
	} else {
		max_side = max_k_v
	}

	return max_side * max_side
}