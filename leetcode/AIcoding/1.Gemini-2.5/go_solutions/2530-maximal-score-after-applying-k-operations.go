package main

import (
	"container/heap"
)

type IntMaxHeap []int

func (h IntMaxHeap) Len() int           { return len(h) }
func (h IntMaxHeap) Less(i, j int) bool { return h[i] > h[j] } // Max-heap: i > j
func (h IntMaxHeap) Swap(i, j int)      { h[i], h[j] = h[j], h[i] }

func (h *IntMaxHeap) Push(x any) {
	*h = append(*h, x.(int))
}

func (h *IntMaxHeap) Pop() any {
	old := *h
	n := len(old)
	x := old[n-1]
	*h = old[0 : n-1]
	return x
}

func maximalScore(nums []int, k int) int64 {
	h := &IntMaxHeap{}
	heap.Init(h)

	for _, num := range nums {
		heap.Push(h, num)
	}

	var totalScore int64 = 0

	for i := 0; i < k; i++ {
		currentMax := heap.Pop(h).(int)
		totalScore += int64(currentMax)

		// Calculate ceil(currentMax / 3) using integer division
		// For positive integers a, b: ceil(a/b) = (a + b - 1) / b
		// Here b = 3, so (currentMax + 3 - 1) / 3 = (currentMax + 2) / 3
		newVal := (currentMax + 2) / 3
		heap.Push(h, newVal)
	}

	return totalScore
}