package main

import (
	"sort"
)

func maxFreeTime(meetings [][]int) int {
	type event struct {
		start int
		end   int
	}
	events := make([]event, len(meetings))
	for i, m := range meetings {
		events[i] = event{start: m[0], end: m[1]}
	}
	sort.Slice(events, func(i, j int) bool {
		return events[i].end < events[j].end
	})

	freeTime := 0
	end := 0

	for _, e := range events {
		if e.start > end {
			freeTime += e.start - end
		}
		if e.end > end {
			end = e.end
		}
	}

	return freeTime
}