package main

import (
	"container/heap"
)

type maxHeap []int

func (h maxHeap) Len() int           { return len(h) }
func (h maxHeap) Less(i, j int) bool { return h[i] > h[j] }
func (h maxHeap) Swap(i, j int)      { h[i], h[j] = h[j], h[i] }

func (h *maxHeap) Push(x interface{}) {
	*h = append(*h, x.(int))
}

func (h *maxHeap) Pop() interface{} {
	old := *h
	n := len(old)
	x := old[n-1]
	*h = old[0 : n-1]
	return x
}

func minimumDeviation(nums []int) int {
	h := &maxHeap{}
	heap.Init(h)

	for _, num := range nums {
		if num%2 == 1 {
			num *= 2
		}
		heap.Push(h, num)
	}

	minVal := *h

	for (*h)[0]%2 == 0 {
		current := heap.Pop(h).(int)
		if current < minVal {
			minVal = current
		}
		current /= 2
		heap.Push(h, current)
	}

	return minVal - (*h)[0]
}