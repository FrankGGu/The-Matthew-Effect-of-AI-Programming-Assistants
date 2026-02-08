package main

import (
	"container/heap"
	"sort"
)

type Event struct {
	x       int
	h       int
	isStart bool
}

type MaxHeap []int

func (h MaxHeap) Len() int           { return len(h) }
func (h MaxHeap) Less(i, j int) bool { return h[i] > h[j] }
func (h MaxHeap) Swap(i, j int)      { h[i], h[j] = h[j], h[i] }

func (h *MaxHeap) Push(x interface{}) {
	*h = append(*h, x.(int))
}

func (h *MaxHeap) Pop() interface{} {
	old := *h
	n := len(old)
	x := old[n-1]
	*h = old[0 : n-1]
	return x
}

func getSkyline(buildings [][]int) [][]int {
	events := make([]Event, 0, len(buildings)*2)
	for _, b := range buildings {
		left, right, height := b[0], b[1], b[2]
		events = append(events, Event{left, height, true})
		events = append(events, Event{right, height, false})
	}

	sort.Slice(events, func(i, j int) bool {
		if events[i].x != events[j].x {
			return events[i].x < events[j].x
		}

		if events[i].isStart && events[j].isStart {
			return events[i].h > events[j].h
		}
		if !events[i].isStart && !events[j].isStart {
			return events[i].h < events[j].h
		}
		return events[i].isStart
	})

	result := [][]int{}

	activeHeightsCount := make(map[int]int)

	h := &MaxHeap{}
	heap.Init(h)

	activeHeightsCount[0] = 1
	heap.Push(h, 0)

	currentMaxHeight := 0

	for _, event := range events {
		if event.isStart {
			activeHeightsCount[event.h]++
			heap.Push(h, event.h)
		} else {
			activeHeightsCount[event.h]--
		}

		for activeHeightsCount[(*h)[0]] == 0 {
			heap.Pop(h)
		}

		newMaxHeight := (*h)[0]

		if newMaxHeight != currentMaxHeight {
			result = append(result, []int{event.x, newMaxHeight})
			currentMaxHeight = newMaxHeight
		}
	}

	return result
}