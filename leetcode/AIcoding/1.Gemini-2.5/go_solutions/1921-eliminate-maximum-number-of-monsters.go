package main

import (
	"sort"
)

func eliminateMaximumMonsters(dist []int, speed []int) int {
	n := len(dist)
	arrivalTimes := make([]int, n)

	for i := 0; i < n; i++ {
		arrivalTimes[i] = (dist[i] + speed[i] - 1) / speed[i]
	}

	sort.Ints(arrivalTimes)

	eliminatedCount := 0

	for i := 0; i < n; i++ {
		if arrivalTimes[i] <= i {
			break
		}
		eliminatedCount++
	}

	return eliminatedCount
}