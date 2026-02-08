package main

import (
	"sort"
	"strconv"
)

func findMinDifference(timePoints []string) int {
	// Optimization: If there are more than 24*60 (1440) distinct time points,
	// by the Pigeonhole Principle, at least two time points must be identical,
	// meaning the minimum difference is 0.
	if len(timePoints) > 1440 {
		return 0
	}

	minutes := make([]int, len(timePoints))

	for i, tp := range timePoints {
		// Parse HH and MM
		hourStr := tp[0:2]
		minuteStr := tp[3:5]

		// strconv.Atoi returns (int, error). We can ignore the error
		// as problem constraints guarantee valid "HH:MM" format.
		hour, _ := strconv.Atoi(hourStr)
		minute, _ := strconv.Atoi(minuteStr)

		minutes[i] = hour*60 + minute
	}

	sort.Ints(minutes)

	// Initialize minDiff with the maximum possible difference (e.g., 24 hours in minutes)
	// The actual max difference between any two distinct times is 1439 (00:00 and 23:59).
	minDiff := 24 * 60 

	// Calculate differences between adjacent time points in the sorted array
	for i := 1; i < len(minutes); i++ {
		diff := minutes[i] - minutes[i-1]
		if diff < minDiff {
			minDiff = diff
		}
		// If minDiff is already 0, we can't get a smaller difference, so return early.
		if minDiff == 0 {
			return 0
		}
	}

	// Calculate the difference between the first and last time points, considering wrap-around
	// For example, if times are [0, 1439] (00:00 and 23:59), the wrap-around difference is:
	// (0 + 24*60) - 1439 = 1440 - 1439 = 1 minute.
	wrapAroundDiff := (minutes[0] + 24*60) - minutes[len(minutes)-1]
	if wrapAroundDiff < minDiff {
		minDiff = wrapAroundDiff
	}

	return minDiff
}