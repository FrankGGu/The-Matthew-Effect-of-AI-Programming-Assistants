package main

import (
	"sort"
)

func maxArea(h int, w int, horizontalCuts []int, verticalCuts []int) int {
	mod := 1_000_000_007

	horizontalCuts = append(horizontalCuts, 0, h)
	sort.Ints(horizontalCuts)

	maxH := 0
	for i := 1; i < len(horizontalCuts); i++ {
		diff := horizontalCuts[i] - horizontalCuts[i-1]
		if diff > maxH {
			maxH = diff
		}
	}

	verticalCuts = append(verticalCuts, 0, w)
	sort.Ints(verticalCuts)

	maxW := 0
	for i := 1; i < len(verticalCuts); i++ {
		diff := verticalCuts[i] - verticalCuts[i-1]
		if diff > maxW {
			maxW = diff
		}
	}

	return int((int64(maxH) * int64(maxW)) % int64(mod))
}