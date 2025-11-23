package main

import (
	"container/heap"
)

type IntHeap []int

func (h IntHeap) Len() int           { return len(h) }
func (h IntHeap) Less(i, j int) bool { return h[i] < h[j] } // Min-heap
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

func magicTower(nums []int) int {
	currentHealth := 1
	reviveCount := 0

	pq := &IntHeap{}
	heap.Init(pq)

	for _, num := range nums {
		currentHealth += num
		heap.Push(pq, num)

		if currentHealth <= 0 {
			reviveCount++
			minVal := heap.Pop(pq).(int)
			currentHealth -= minVal
		}
	}

	if currentHealth <= 0 {
		return -1
	}

	return reviveCount
}