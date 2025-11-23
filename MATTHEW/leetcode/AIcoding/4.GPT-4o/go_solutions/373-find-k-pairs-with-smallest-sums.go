package main

import (
	"container/heap"
	"sort"
)

type Pair struct {
	sum   int
	index [2]int
}

type MinHeap []Pair

func (h MinHeap) Len() int           { return len(h) }
func (h MinHeap) Less(i, j int) bool { return h[i].sum < h[j].sum }
func (h MinHeap) Swap(i, j int)      { h[i], h[j] = h[j], h[i] }

func (h *MinHeap) Push(x interface{}) {
	*h = append(*h, x.(Pair))
}

func (h *MinHeap) Pop() interface{} {
	old := *h
	n := len(old)
	x := old[n-1]
	*h = old[0 : n-1]
	return x
}

func kSmallestPairs(nums1 []int, nums2 []int, k int) [][]int {
	if len(nums1) == 0 || len(nums2) == 0 || k == 0 {
		return [][]int{}
	}

	minHeap := &MinHeap{}
	heap.Init(minHeap)

	for i := 0; i < len(nums1) && i < k; i++ {
		heap.Push(minHeap, Pair{sum: nums1[i] + nums2[0], index: [2]int{i, 0}})
	}

	result := [][]int{}

	for len(result) < k && minHeap.Len() > 0 {
		pair := heap.Pop(minHeap).(Pair)
		result = append(result, []int{nums1[pair.index[0]], nums2[pair.index[1]]})

		if pair.index[1]+1 < len(nums2) {
			nextPair := Pair{sum: nums1[pair.index[0]] + nums2[pair.index[1]+1], index: [2]int{pair.index[0], pair.index[1] + 1}}
			heap.Push(minHeap, nextPair)
		}
	}

	return result
}