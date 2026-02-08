package main

import (
	"sort"
)

func maxSatisfaction(satisfaction []int) int {
	sort.Ints(satisfaction)

	n := len(satisfaction)
	currentSum := 0
	prefixSum := 0
	maxVal := 0

	for i := n - 1; i >= 0; i-- {
		prefixSum += satisfaction[i]
		currentSum += prefixSum
		if currentSum > maxVal {
			maxVal = currentSum
		}
	}

	return maxVal
}