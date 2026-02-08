package main

import (
	"container/heap"
)

type IntHeap []int

func (h IntHeap) Len() int           { return len(h) }
func (h IntHeap) Less(i, j int) bool { return h[i] < h[j] }
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

func minTimeForSecurityCheck(times []int, k int) int {
	if len(times) == 0 {
		return 0
	}

	if k <= 0 {
		return 0
	}

	h := &IntHeap{}
	heap.Init(h)

	for i := 0; i < k; i++ {
		heap.Push(h, 0)
	}

	maxFinishTime := 0

	for _, personProcessingTime := range times {
		earliestFreeTime := heap.Pop(h).(int)
		currentPersonFinishTime := earliestFreeTime + personProcessingTime
		if currentPersonFinishTime > maxFinishTime {
			maxFinishTime = currentPersonFinishTime
		}
		heap.Push(h, currentPersonFinishTime)
	}

	return maxFinishTime
}