package main

import (
	"sort"
)

func merge(intervals [][]int) [][]int {
	if len(intervals) <= 1 {
		return intervals
	}

	sort.Slice(intervals, func(i, j int) bool {
		return intervals[i][0] < intervals[j][0]
	})

	var merged [][]int
	merged = append(merged, intervals[0])

	for i := 1; i < len(intervals); i++ {
		lastMerged := merged[len(merged)-1]
		currentInterval := intervals[i]

		if currentInterval[0] <= lastMerged[1] {
			if currentInterval[1] > lastMerged[1] {
				merged[len(merged)-1][1] = currentInterval[1]
			}
		} else {
			merged = append(merged, currentInterval)
		}
	}

	return merged
}