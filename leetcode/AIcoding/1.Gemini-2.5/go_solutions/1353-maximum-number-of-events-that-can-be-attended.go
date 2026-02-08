package main

import (
	"container/heap"
	"sort"
)

type MinHeap []int

func (h MinHeap) Len() int           { return len(h) }
func (h MinHeap) Less(i, j int) bool { return h[i] < h[j] }
func (h MinHeap) Swap(i, j int)      { h[i], h[j] = h[j], h[i] }

func (h *MinHeap) Push(x interface{}) {
	*h = append(*h, x.(int))
}

func (h *MinHeap) Pop() interface{} {
	old := *h
	n := len(old)
	x := old[n-1]
	*h = old[0 : n-1]
	return x
}

func maxEvents(events [][]int) int {
	sort.Slice(events, func(i, j int) bool {
		if events[i][0] != events[j][0] {
			return events[i][0] < events[j][0]
		}
		return events[i][1] < events[j][1]
	})

	n := len(events)
	attendedEvents := 0
	currentEventIdx := 0
	maxDay := 0

	// Determine the maximum possible day an event can end to set the loop limit
	for _, event := range events {
		if event[1] > maxDay {
			maxDay = event[1]
		}
	}

	h := &MinHeap{}
	heap.Init(h)

	for day := 1; day <= maxDay; day++ {
		// Add all events that start on 'day' to the min-heap
		for currentEventIdx < n && events[currentEventIdx][0] == day {
			heap.Push(h, events[currentEventIdx][1]) // Push end day of the event
			currentEventIdx++
		}

		// Remove events from the heap that have already ended before 'day'
		for h.Len() > 0 && (*h)[0] < day {
			heap.Pop(h)
		}

		// If there are available events, attend the one that ends earliest
		if h.Len() > 0 {
			heap.Pop(h) // Attend this event
			attendedEvents++
		}
	}

	return attendedEvents
}