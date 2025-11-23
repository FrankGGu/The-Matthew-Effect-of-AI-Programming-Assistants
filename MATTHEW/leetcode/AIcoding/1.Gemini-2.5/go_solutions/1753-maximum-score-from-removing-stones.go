package main

import (
	"container/heap"
)

type IntHeap []int

func (h IntHeap) Len() int { return len(h) }
func (h IntHeap) Less(i, j int) bool { return h[i] > h[j] } // Max-heap
func (h IntHeap) Swap(i, j int) { h[i], h[j] = h[j], h[i] }

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

func maximumScore(a int, b int, c int) int {
	h := &IntHeap{}
	heap.Init(h)

	if a > 0 {
		heap.Push(h, a)
	}
	if b > 0 {
		heap.Push(h, b)
	}
	if c > 0 {
		heap.Push(h, c)
	}

	score := 0
	for h.Len() >= 2 {
		val1 := heap.Pop(h).(int)
		val2 := heap.Pop(h).(int)

		score++
		val1--
		val2--

		if val1 > 0 {
			heap.Push(h, val1)
		}
		if val2 > 0 {
			heap.Push(h, val2)
		}
	}

	return score
}