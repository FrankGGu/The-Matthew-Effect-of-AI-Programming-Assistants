package main

import (
	"sort"
)

func countDaysWithoutMeetings(days int, meetings [][]int) int {
	if len(meetings) == 0 {
		return days
	}

	sort.Slice(meetings, func(i, j int) bool {
		return meetings[i][0] < meetings[j][0]
	})

	totalCoveredDays := 0
	currentStart := -1
	currentEnd := -1

	for _, meeting := range meetings {
		start := meeting[0]
		end := meeting[1]

		if currentStart == -1 {
			currentStart = start
			currentEnd = end
		} else if start <= currentEnd+1 {
			if end > currentEnd {
				currentEnd = end
			}
		} else {
			totalCoveredDays += (currentEnd - currentStart + 1)
			currentStart = start
			currentEnd = end
		}
	}

	if currentStart != -1 {
		totalCoveredDays += (currentEnd - currentStart + 1)
	}

	return days - totalCoveredDays
}