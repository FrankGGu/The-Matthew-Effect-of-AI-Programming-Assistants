package main

import (
	"container/heap"
	"math"
)

type MaxHeap []int

func (h MaxHeap) Len() int           { return len(h) }
func (h MaxHeap) Less(i, j int) bool { return h[i] > h[j] } // Max-heap: greater value means higher priority
func (h MaxHeap) Swap(i, j int)      { h[i], h[j] = h[j], h[i] }

func (h *MaxHeap) Push(x any) {
	*h = append(*h, x.(int))
}

func (h *MaxHeap) Pop() any {
	old := *h
	n := len(old)
	x := old[n-1]
	*h = old[0 : n-1]
	return x
}

func minimumDeviation(nums []int) int {
	maxHeap := &MaxHeap{}
	heap.Init(maxHeap)

	currentMin := math.MaxInt32

	for _, num := range nums {
		if num%2 == 1 {
			num *= 2
		}
		heap.Push(maxHeap, num)
		if num < currentMin {
			currentMin = num
		}
	}

	minDeviation := math.MaxInt32

	for {
		maxVal := heap.Pop(maxHeap).(int)

		minDeviation = min(minDeviation, maxVal-currentMin)

		if maxVal%2 == 1 {
			break
		}

		maxVal /= 2
		heap.Push(maxHeap, maxVal)

		if maxVal < currentMin {
			currentMin = maxVal
		}
	}

	return minDeviation
}

func min(a, b int) int {
	if a < b {
		return a
	}
	return b
}