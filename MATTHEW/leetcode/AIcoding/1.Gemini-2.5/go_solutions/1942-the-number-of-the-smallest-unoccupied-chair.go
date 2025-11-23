package main

import (
	"container/heap"
	"sort"
)

type event struct {
	time      int
	eventType int // 1 for arrival, -1 for departure
	personIdx int
}

type minHeapChairs []int

func (h minHeapChairs) Len() int           { return len(h) }
func (h minHeapChairs) Less(i, j int) bool { return h[i] < h[j] }
func (h minHeapChairs) Swap(i, j int)      { h[i], h[j] = h[j], h[i] }
func (h *minHeapChairs) Push(x interface{}) {
	*h = append(*h, x.(int))
}
func (h *minHeapChairs) Pop() interface{} {
	old := *h
	n := len(old)
	x := old[n-1]
	*h = old[0 : n-1]
	return x
}

type occupiedChair struct {
	departureTime int
	chairNumber   int
}

type minHeapOccupied []occupiedChair

func (h minHeapOccupied) Len() int { return len(h) }
func (h minHeapOccupied) Less(i, j int) bool {
	return h[i].departureTime < h[j].departureTime
}
func (h minHeapOccupied) Swap(i, j int) { h[i], h[j] = h[j], h[i] }
func (h *minHeapOccupied) Push(x interface{}) {
	*h = append(*h, x.(occupiedChair))
}
func (h *minHeapOccupied) Pop() interface{} {
	old := *h
	n := len(old)
	x := old[n-1]
	*h = old[0 : n-1]
	return x
}

func smallestUnoccupiedChair(n int, times [][]int, targetFriend int) int {
	events := []event{}
	for i := 0; i < len(times); i++ {
		events = append(events, event{times[i][0], 1, i})
		events = append(events, event{times[i][1], -1, i})
	}

	sort.Slice(events, func(i, j int) bool {
		if events[i].time != events[j].time {
			return events[i].time < events[j].time
		}
		return events[i].eventType < events[j].eventType
	})

	availableChairs := &minHeapChairs{}
	heap.Init(availableChairs)
	for i := 0; i < n; i++ {
		heap.Push(availableChairs, i)
	}

	occupiedChairs := &minHeapOccupied{}
	heap.Init(occupiedChairs)

	for _, e := range events {
		for occupiedChairs.Len() > 0 && (*occupiedChairs)[0].departureTime <= e.time {
			chair := heap.Pop(occupiedChairs).(occupiedChair)
			heap.Push(availableChairs, chair.chairNumber)
		}

		if e.eventType == 1 {
			chairNum := heap.Pop(availableChairs).(int)
			if e.personIdx == targetFriend {
				return chairNum
			}
			heap.Push(occupiedChairs, occupiedChair{times[e.personIdx][1], chairNum})
		}
	}
	return -1
}