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

func maximumProduct(nums []int, k int) int {
	h := &IntHeap{}
	heap.Init(h)

	for _, num := range nums {
		heap.Push(h, num)
	}

	for i := 0; i < k; i++ {
		minVal := heap.Pop(h).(int)
		heap.Push(h, minVal+1)
	}

	mod := 1_000_000_007
	product := 1
	for h.Len() > 0 {
		val := heap.Pop(h).(int)
		product = (product * val) % mod
	}

	return product
}