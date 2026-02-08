package main

import "sort"

func maxTwoEvents(events [][]int) int {
	type Event struct {
		start int
		end   int
	value int
	}

	var eventList []Event
	for _, event := range events {
		eventList = append(eventList, Event{event[0], event[1], event[2]})
	}
	sort.Slice(eventList, func(i, j int) bool {
		return eventList[i].end < eventList[j].end
	})

	n := len(eventList)
	maxValue := make([]int, n)
	for i := 0; i < n; i++ {
		maxValue[i] = eventList[i].value
	}

	for i := 0; i < n; i++ {
		for j := i - 1; j >= 0; j-- {
			if eventList[j].end < eventList[i].start {
				maxValue[i] = max(maxValue[i], maxValue[j]+eventList[i].value)
				break
			}
		}
	}

	res := 0
	for i := 0; i < n; i++ {
		res = max(res, maxValue[i])
	}
	return res
}

func max(a, b int) int {
	if a > b {
		return a
	}
	return b
}