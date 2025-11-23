package main

import (
	"container/heap"
	"sort"
)

type Item struct {
	sum    int
	indexs []int
}

type MinHeap []Item

func (h MinHeap) Len() int           { return len(h) }
func (h MinHeap) Less(i, j int) bool { return h[i].sum < h[j].sum }
func (h MinHeap) Swap(i, j int)      { h[i], h[j] = h[j], h[i] }

func (h *MinHeap) Push(x interface{}) {
	*h = append(*h, x.(Item))
}

func (h *MinHeap) Pop() interface{} {
	old := *h
	n := len(old)
	item := old[n-1]
	*h = old[0 : n-1]
	return item
}

func kthSmallest(mat [][]int, k int) int {
	n := len(mat)
	m := len(mat[0])
	h := &MinHeap{}
	heap.Init(h)

	initialSum := 0
	indexes := make([]int, n)
	for i := 0; i < n; i++ {
		initialSum += mat[i][0]
	}
	heap.Push(h, Item{sum: initialSum, indexs: indexes})

	for i := 1; i < k; i++ {
		item := heap.Pop(h).(Item)

		for j := 0; j < n; j++ {
			if item.indexs[j]+1 < m {
				newIndexes := make([]int, n)
				copy(newIndexes, item.indexs)
				newIndexes[j]++

				newSum := item.sum - mat[j][item.indexs[j]] + mat[j][newIndexes[j]]
				heap.Push(h, Item{sum: newSum, indexs: newIndexes})
			}
		}
	}

	return heap.Pop(h).(Item).sum
}