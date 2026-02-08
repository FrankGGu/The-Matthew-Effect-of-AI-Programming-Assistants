package main

import (
	"container/heap"
	"math"
)

type MaxHeap []int

func (h MaxHeap) Len() int           { return len(h) }
func (h MaxHeap) Less(i, j int) bool { return h[i] > h[j] } // Max-heap
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

func minStoneSum(piles []int, k int) int {
	h := &MaxHeap{}
	heap.Init(h)

	for _, pile := range piles {
		heap.Push(h, pile)
	}

	for i := 0; i < k; i++ {
		if h.Len() == 0 {
			break
		}
		maxPile := heap.Pop(h).(int)
		removedStones := int(math.Floor(float64(maxPile) / 2.0))
		newPile := maxPile - removedStones
		heap.Push(h, newPile)
	}

	totalStones := 0
	for h.Len() > 0 {
		totalStones += heap.Pop(h).(int)
	}

	return totalStones
}