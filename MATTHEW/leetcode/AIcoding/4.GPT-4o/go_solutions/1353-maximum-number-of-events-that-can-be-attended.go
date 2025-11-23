package main

import (
	"container/heap"
	"sort"
)

type Event struct {
	start int
	end   int
}

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
	n := len(events)
	eventList := make([]Event, n)
	for i, e := range events {
		eventList[i] = Event{start: e[0], end: e[1]}
	}

	sort.Slice(eventList, func(i, j int) bool {
		return eventList[i].start < eventList[j].start
	})

	h := &MinHeap{}
	heap.Init(h)
	result := 0
	currentDay := 0
	i := 0

	for i < n || h.Len() > 0 {
		if h.Len() == 0 {
			currentDay = eventList[i].start
		}

		for i < n && eventList[i].start <= currentDay {
			heap.Push(h, eventList[i].end)
			i++
		}

		heap.Pop(h)
		result++
		currentDay++
		for h.Len() > 0 && (*h)[0] < currentDay {
			heap.Pop(h)
		}
	}

	return result
}