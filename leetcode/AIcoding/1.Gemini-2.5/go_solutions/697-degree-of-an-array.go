package main

import "math"

func findShortestSubArray(nums []int) int {
	counts := make(map[int]int)
	firstSeen := make(map[int]int)
	lastSeen := make(map[int]int)

	for i, num := range nums {
		counts[num]++
		if _, ok := firstSeen[num]; !ok {
			firstSeen[num] = i
		}
		lastSeen[num] = i
	}

	degree := 0
	for _, count := range counts {
		if count > degree {
			degree = count
		}
	}

	minLen := math.MaxInt32
	for num, count := range counts {
		if count == degree {
			length := lastSeen[num] - firstSeen[num] + 1
			if length < minLen {
				minLen = length
			}
		}
	}

	return minLen
}