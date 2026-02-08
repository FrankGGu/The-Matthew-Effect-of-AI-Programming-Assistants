package main

import (
	"container/heap"
)

type IntHeap []int

func (h IntHeap) Len() int           { return len(h) }
func (h IntHeap) Less(i, j int) bool { return h[i] > h[j] } // Max-heap
func (h IntHeap) Swap(i, j int)      { h[i], h[j] = h[j], h[i] }

func (h *IntHeap) Push(x interface{}) {
	*h = append(*h, x.(int))
}

func (h *IntHeap) Pop() interface{} {
	old := *h
	n := len(old)
	x := old[n-1]
	*h = old[0 : n-1]
	return x
}

func minRefuelStops(target int, startFuel int, stations [][]int) int {
	h := &IntHeap{}
	heap.Init(h)

	stops := 0
	currentFuel := startFuel

	for _, station := range stations {
		stationPos := station[0]
		stationFuel := station[1]

		for currentFuel < stationPos && h.Len() > 0 {
			currentFuel += heap.Pop(h).(int)
			stops++
		}

		if currentFuel < stationPos {
			return -1
		}

		heap.Push(h, stationFuel)
	}

	for currentFuel < target && h.Len() > 0 {
		currentFuel += heap.Pop(h).(int)
		stops++
	}

	if currentFuel < target {
		return -1
	}

	return stops
}