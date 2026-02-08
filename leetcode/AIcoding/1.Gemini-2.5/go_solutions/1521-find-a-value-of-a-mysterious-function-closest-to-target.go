package main

import (
	"math"
)

func abs(x int) int {
	if x < 0 {
		return -x
	}
	return x
}

func closestToTarget(arr []int, target int) int {
	minDiff := math.MaxInt32

	currentAnds := make(map[int]struct{})

	for _, num := range arr {
		nextAnds := make(map[int]struct{})

		nextAnds[num] = struct{}{}

		for val := range currentAnds {
			nextAnds[val&num] = struct{}{}
		}

		for val := range nextAnds {
			diff := abs(val - target)
			if diff < minDiff {
				minDiff = diff
			}
		}

		currentAnds = nextAnds
	}

	return minDiff
}