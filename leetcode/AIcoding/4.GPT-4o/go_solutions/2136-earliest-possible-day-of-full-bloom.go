package main

import (
	"sort"
)

func earliestFullBloom(plants []int, growTime []int) int {
	n := len(plants)
	plantsWithGrowTime := make([][2]int, n)
	for i := 0; i < n; i++ {
		plantsWithGrowTime[i] = [2]int{growTime[i], plants[i]}
	}
	sort.Slice(plantsWithGrowTime, func(i, j int) bool {
		return plantsWithGrowTime[i][0] > plantsWithGrowTime[j][0]
	})

	currentDay := 0
	maxDay := 0
	for _, p := range plantsWithGrowTime {
		currentDay += p[1]
		maxDay = max(maxDay, currentDay+p[0])
	}
	return maxDay
}

func max(a, b int) int {
	if a > b {
		return a
	}
	return b
}