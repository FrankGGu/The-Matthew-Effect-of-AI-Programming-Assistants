package main

import (
	"sort"
	"strconv"
	"strings"
)

func findMinDifference(timePoints []string) int {
	timeMap := make([]int, len(timePoints))
	for i, time := range timePoints {
		parts := strings.Split(time, ":")
		hour, _ := strconv.Atoi(parts[0])
		minute, _ := strconv.Atoi(parts[1])
		timeMap[i] = hour*60 + minute
	}
	sort.Ints(timeMap)
	minDiff := 1440 // 24 * 60
	for i := 1; i < len(timeMap); i++ {
		minDiff = min(minDiff, timeMap[i]-timeMap[i-1])
	}
	minDiff = min(minDiff, (timeMap[0]+1440)-timeMap[len(timeMap)-1])
	return minDiff
}

func min(a, b int) int {
	if a < b {
		return a
	}
	return b
}