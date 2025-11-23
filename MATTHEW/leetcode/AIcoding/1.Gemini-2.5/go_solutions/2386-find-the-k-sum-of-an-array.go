package main

import (
	"container/heap"
	"sort"
)

type Item struct {
	sum   int64
	index int
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

func kSum(nums []int, k int) int64 {
	var maxSum int64
	n := len(nums)

	absNums := make([]int64, n)
	for i := 0; i < n; i++ {
		if nums[i] >= 0 {
			maxSum += int64(nums[i])
			absNums[i] = int64(nums[i])
		} else {
			absNums[i] = int64(-nums[i])
		}
	}

	sort.Slice(absNums, func(i, j int) bool {
		return absNums[i] < absNums[j]
	})

	pq := &MinHeap{}
	heap.Init(pq)

	heap.Push(pq, Item{sum: 0, index: -1})

	smallestDeviationSums := make([]int64, 0, k)

	for len(*pq) > 0 && len(smallestDeviationSums) < k {
		item := heap.Pop(pq).(Item)
		currentSum := item.sum
		lastIndex := item.index

		smallestDeviationSums = append(smallestDeviationSums, currentSum)

		if lastIndex+1 < n {
			heap.Push(pq, Item{sum: currentSum + absNums[lastIndex+1], index: lastIndex + 1})

			if lastIndex >= 0 {
				heap.Push(pq, Item{sum: currentSum - absNums[lastIndex] + absNums[lastIndex+1], index: lastIndex + 1})
			}
		}
	}

	return maxSum - smallestDeviationSums[k-1]
}