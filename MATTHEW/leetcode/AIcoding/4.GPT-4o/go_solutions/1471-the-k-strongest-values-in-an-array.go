package main

import (
	"container/heap"
	"sort"
)

type Item struct {
	value int
	index int
}

type MaxHeap []Item

func (h MaxHeap) Len() int           { return len(h) }
func (h MaxHeap) Less(i, j int) bool { return h[i].value > h[j].value }
func (h MaxHeap) Swap(i, j int)      { h[i], h[j] = h[j], h[i] }

func (h *MaxHeap) Push(x interface{}) {
	*h = append(*h, x.(Item))
}

func (h *MaxHeap) Pop() interface{} {
	old := *h
	n := len(old)
	item := old[n-1]
	*h = old[0 : n-1]
	return item
}

func getStrongest(arr []int, k int) []int {
	sort.Ints(arr)
	n := len(arr)
	mid := arr[(n-1)/2]
	h := &MaxHeap{}

	for i, v := range arr {
		heap.Push(h, Item{value: abs(v - mid), index: v})
	}

	result := make([]int, 0, k)
	for i := 0; i < k; i++ {
		result = append(result, heap.Pop(h).(Item).index)
	}

	return result
}

func abs(x int) int {
	if x < 0 {
		return -x
	}
	return x
}