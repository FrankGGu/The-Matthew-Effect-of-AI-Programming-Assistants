package main

import (
	"container/heap"
)

type Pair struct {
	num1 int
	num2 int
	sum  int
}

type MinHeap []*Pair

func (h MinHeap) Len() int           { return len(h) }
func (h MinHeap) Less(i, j int) bool { return h[i].sum < h[j].sum }
func (h MinHeap) Swap(i, j int)      { h[i], h[j] = h[j], h[i] }

func (h *MinHeap) Push(x interface{}) {
	*h = append(*h, x.(*Pair))
}

func (h *MinHeap) Pop() interface{} {
	old := *h
	n := len(old)
	x := old[n-1]
	*h = old[0 : n-1]
	return x
}

func kSmallestPairs(nums1 []int, nums2 []int, k int) [][]int {
	if len(nums1) == 0 || len(nums2) == 0 {
		return [][]int{}
	}

	h := &MinHeap{}
	heap.Init(h)
	heap.Push(h, &Pair{nums1[0], nums2[0], nums1[0] + nums2[0]})

	visited := make(map[string]bool)
	visited["0,0"] = true

	result := [][]int{}

	for h.Len() > 0 && len(result) < k {
		pair := heap.Pop(h).(*Pair)
		result = append(result, []int{pair.num1, pair.num2})

		i, j := -1, -1
		for idx, p := range *h {
			if p.num1 == pair.num1 && p.num2 == pair.num2 {
				i = idx
				break
			}
		}

		if i != -1 {
			*h = append((*h)[:i], (*h)[i+1:]...)
		}

		if !visited[fmt.Sprintf("%d,%d", pair.num1, nums2[1])] {
			visited[fmt.Sprintf("%d,%d", pair.num1, nums2[1])] = true
			heap.Push(h, &Pair{pair.num1, nums2[1], pair.num1 + nums2[1]})
		}

		if !visited[fmt.Sprintf("%d,%d", nums1[1], pair.num2)] {
			visited[fmt.Sprintf("%d,%d", nums1[1], pair.num2)] = true
			heap.Push(h, &Pair{nums1[1], pair.num2, nums1[1] + pair.num2})
		}
	}

	return result
}