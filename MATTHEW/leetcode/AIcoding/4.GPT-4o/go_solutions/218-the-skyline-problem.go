package main

import (
	"container/heap"
	"sort"
)

type Event struct {
	x      int
	height int
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
	events := []Event{}
	for _, b := range buildings {
		events = append(events, Event{x: b[0], height: b[2], isStart: true}, Event{x: b[1], height: b[2], isStart: false})
	}
	sort.Slice(events, func(i, j int) bool {
		if events[i].x == events[j].x {
			if events[i].isStart && events[j].isStart {
				return events[i].height > events[j].height
			}
			if !events[i].isStart && !events[j].isStart {
				return events[i].height < events[j].height
			}
			return events[i].isStart
		}
		return events[i].x < events[j].x
	})

	result := [][]int{}
	h := &MaxHeap{}
	heap.Push(h, 0)
	prevHeight := 0

	for _, event := range events {
		if event.isStart {
			heap.Push(h, event.height)
		} else {
			for i, height := range *h {
				if height == event.height {
					heap.Remove(h, i)
					break
				}
			}
		}
		currentHeight := (*h)[0]
		if currentHeight != prevHeight {
			result = append(result, []int{event.x, currentHeight})
			prevHeight = currentHeight
		}
	}
	return result
}