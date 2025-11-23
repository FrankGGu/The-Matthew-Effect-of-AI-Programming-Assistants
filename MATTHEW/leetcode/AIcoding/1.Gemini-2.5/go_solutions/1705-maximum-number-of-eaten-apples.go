package main

import (
	"container/heap"
)

type Apple struct {
	expiryDay int
	count     int
}

type MinHeap []Apple

func (h MinHeap) Len() int { return len(h) }
func (h MinHeap) Less(i, j int) bool {
	return h[i].expiryDay < h[j].expiryDay
}
func (h MinHeap) Swap(i, j int) { h[i], h[j] = h[j], h[i] }

func (h *MinHeap) Push(x interface{}) {
	*h = append(*h, x.(Apple))
}

func (h *MinHeap) Pop() interface{} {
	old := *h
	n := len(old)
	x := old[n-1]
	*h = old[0 : n-1]
	return x
}

func maxApples(apples []int, ripe []int) int {
	n := len(apples)
	h := &MinHeap{}
	heap.Init(h)

	eatenApples := 0
	day := 0

	for day < n || h.Len() > 0 {
		// 1. Add new apples for the current day if available
		if day < n && apples[day] > 0 {
			heap.Push(h, Apple{expiryDay: day + ripe[day], count: apples[day]})
		}

		// 2. Remove expired apples from the heap
		// An apple with expiryDay 'X' is fresh until the end of day 'X-1'.
		// On day 'X', it is rotten. So if current 'day' is 'X', and 'expiryDay' is 'X', it's rotten.
		for h.Len() > 0 && h.MinHeap[0].expiryDay <= day {
			heap.Pop(h)
		}

		// 3. Eat an apple if available
		if h.Len() > 0 {
			// Get the apple batch that expires soonest
			top := heap.Pop(h).(Apple)
			top.count--
			eatenApples++
			// If there are still apples left in this batch, push it back
			if top.count > 0 {
				heap.Push(h, top)
			}
		}

		day++
	}

	return eatenApples
}