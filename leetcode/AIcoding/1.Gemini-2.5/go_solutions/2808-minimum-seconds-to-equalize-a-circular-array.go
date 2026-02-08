package main

import (
	"math"
)

func minimumSeconds(nums []int) int {
	n := len(nums)
	valToIndices := make(map[int][]int)

	for i, num := range nums {
		valToIndices[num] = append(valToIndices[num], i)
	}

	minMaxSeconds := math.MaxInt32

	for _, indices := range valToIndices {
		currentMaxGap := 0
		if len(indices) == 1 {
			// If a value appears only once, the gap is n-1 (all other elements)
			currentMaxGap = n - 1
		} else {
			// Calculate max gap between consecutive occurrences
			for i := 0; i < len(indices)-1; i++ {
				gap := indices[i+1] - indices[i] - 1
				if gap > currentMaxGap {
					currentMaxGap = gap
				}
			}
			// Calculate circular gap
			circularGap := n - indices[len(indices)-1] + indices[0] - 1
			if circularGap > currentMaxGap {
				currentMaxGap = circularGap
			}
		}

		// Seconds needed to fill this max gap is (gap_length + 1) / 2
		secondsForVal := (currentMaxGap + 1) / 2
		if secondsForVal < minMaxSeconds {
			minMaxSeconds = secondsForVal
		}
	}

	return minMaxSeconds
}