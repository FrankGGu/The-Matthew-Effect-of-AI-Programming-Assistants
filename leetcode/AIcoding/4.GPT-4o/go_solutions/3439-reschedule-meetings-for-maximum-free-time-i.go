package main

import (
	"sort"
)

type Interval struct {
	start int
	end   int
}

func maxFreeTime(meetings [][]int) [][]int {
	intervals := make([]Interval, len(meetings))
	for i, m := range meetings {
		intervals[i] = Interval{m[0], m[1]}
	}
	sort.Slice(intervals, func(i, j int) bool {
		return intervals[i].start < intervals[j].start
	})

	var freeTime [][]int
	end := intervals[0].end

	for i := 1; i < len(intervals); i++ {
		if intervals[i].start > end {
			freeTime = append(freeTime, []int{end, intervals[i].start})
		}
		if intervals[i].end > end {
			end = intervals[i].end
		}
	}

	return freeTime
}