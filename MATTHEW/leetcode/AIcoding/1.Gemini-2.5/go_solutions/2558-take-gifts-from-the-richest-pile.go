package main

import (
	"container/heap"
	"math"
)

type IntHeap []int

func (h IntHeap) Len() int           { return len(h) }
func (h IntHeap) Less(i, j int) bool { return h[i] > h[j] } // Max-heap
func (h IntHeap) Swap(i, j int)      { h[i], h[j] = h[j], h[i] }

func (h *IntHeap) Push(x any) {
	*h = append(*h, x.(int))
}

func (h *IntHeap) Pop() any {
	old := *h
	n := len(old)
	x := old[n-1]
	*h = old[0 : n-1]
	return x
}

func pickGifts(piles []int, k int) int6g {
	h := &IntHeap{}
	heap.Init(h)

	for _, pile := range piles {
		heap.Push(h, pile)
	}

	for i := 0; i < k; i++ {
		richest := heap.Pop(h).(int)
		newPile := int(math.Sqrt(float64(richest)))
		heap.Push(h, newPile)
	}

	var totalGifts int
	for h.Len() > 0 {
		totalGifts += heap.Pop(h).(int)
	}

	return totalGifts
}