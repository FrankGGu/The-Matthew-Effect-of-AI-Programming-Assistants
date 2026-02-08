package main

import (
	"container/heap"
)

type Pair struct {
	sum  int
	idx1 int
	idx2 int
}

type MinHeap []Pair

func (h MinHeap) Len() int { return len(h) }
func (h MinHeap) Less(i, j int) bool { return h[i].sum < h[j].sum }
func (h MinHeap) Swap(i, j int) { h[i], h[j] = h[j], h[i] }

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
	result := make([][]int, 0, k)

	if len(nums1) == 0 || len(nums2) == 0 || k == 0 {
		return result
	}

	h := &MinHeap{}
	heap.Init(h)

	for i := 0; i < len(nums1) && i < k; i++ {
		heap.Push(h, Pair{nums1[i] + nums2[0], i, 0})
	}

	for k > 0 && h.Len() > 0 {
		p := heap.Pop(h).(Pair)
		result = append(result, []int{nums1[p.idx1], nums2[p.idx2]})
		k--

		if p.idx2+1 < len(nums2) {
			heap.Push(h, Pair{nums1[p.idx1] + nums2[p.idx2+1], p.idx1, p.idx2 + 1})
		}
	}

	return result
}