package main

import (
	"sort"
)

type event struct {
	point       int
	colorChange int64
}

func describeThePainting(paintings [][]int) [][]int64 {
	events := make([]event, 0, len(paintings)*2)
	for _, p := range paintings {
		start, end, color := p[0], p[1], p[2]
		events = append(events, event{point: start, colorChange: int64(color)})
		events = append(events, event{point: end, colorChange: int64(-color)})
	}

	sort.Slice(events, func(i, j int) bool {
		if events[i].point != events[j].point {
			return events[i].point < events[j].point
		}
		return events[i].colorChange > events[j].colorChange
	})

	result := [][]int64{}
	var currentSum int64 = 0

	if len(events) == 0 {
		return result
	}

	prevPoint := events[0].point

	for _, e := range events {
		if e.point > prevPoint && currentSum > 0 {
			result = append(result, []int64{int64(prevPoint), int64(e.point), currentSum})
		}

		currentSum += e.colorChange
		prevPoint = e.point
	}

	return result
}