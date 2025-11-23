package main

import (
	"sort"
)

func minNumberOfChairs(times [][]int) int {
	if len(times) == 0 {
		return 0
	}

	startTimes := make([]int, len(times))
	endTimes := make([]int, len(times))

	for i, time := range times {
		startTimes[i] = time[0]
		endTimes[i] = time[1]
	}

	sort.Ints(startTimes)
	sort.Ints(endTimes)

	chairs := 0
	endPtr := 0

	for i := 0; i < len(times); i++ {
		if startTimes[i] < endTimes[endPtr] {
			chairs++
		} else {
			endPtr++
		}
	}

	return chairs
}