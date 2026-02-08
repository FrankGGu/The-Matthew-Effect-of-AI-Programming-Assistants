package main

import (
	"container/heap"
)

type MaxHeap []float64

func (h MaxHeap) Len() int           { return len(h) }
func (h MaxHeap) Less(i, j int) bool { return h[i] > h[j] }
func (h MaxHeap) Swap(i, j int)      { h[i], h[j] = h[j], h[i] }

func (h *MaxHeap) Push(x any) {
	*h = append(*h, x.(float64))
}

func (h *MaxHeap) Pop() any {
	old := *h
	n := len(old)
	x := old[n-1]
	*h = old[0 : n-1]
	return x
}

func halveArray(nums []int) int {
	initialSum := 0.0
	h := &MaxHeap{}
	heap.Init(h)

	for _, num := range nums {
		initialSum += float64(num)
		heap.Push(h, float64(num))
	}

	targetSum := initialSum / 2.0
	currentReducedSum := 0.0
	operations := 0

	for currentReducedSum < targetSum {
		maxVal := heap.Pop(h).(float64)
		halfVal := maxVal / 2.0
		currentReducedSum += halfVal
		heap.Push(h, halfVal)
		operations++
	}

	return operations
}