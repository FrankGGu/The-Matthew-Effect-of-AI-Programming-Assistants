package main

import (
	"container/heap"
	"math"
)

type IntMaxHeap []int

func (h IntMaxHeap) Len() int           { return len(h) }
func (h IntMaxHeap) Less(i, j int) bool { return h[i] > h[j] }
func (h IntMaxHeap) Swap(i, j int)      { h[i], h[j] = h[j], h[i] }

func (h *IntMaxHeap) Push(x interface{}) {
	*h = append(*h, x.(int))
}

func (h *IntMaxHeap) Pop() interface{} {
	old := *h
	n := len(old)
	x := old[n-1]
	*h = old[0 : n-1]
	return x
}

type IntMinHeap []int

func (h IntMinHeap) Len() int           { return len(h) }
func (h IntMinHeap) Less(i, j int) bool { return h[i] < h[j] }
func (h IntMinHeap) Swap(i, j int)      { h[i], h[j] = h[j], h[i] }

func (h *IntMinHeap) Push(x interface{}) {
	*h = append(*h, x.(int))
}

func (h *IntMinHeap) Pop() interface{} {
	old := *h
	n := len(old)
	x := old[n-1]
	*h = old[0 : n-1]
	return x
}

func min(a, b int64) int64 {
	if a < b {
		return a
	}
	return b
}

func minimumDifference(nums []int) int64 {
	n := len(nums) / 3

	leftSum := int64(0)
	pqLeft := &IntMaxHeap{}
	heap.Init(pqLeft)
	leftSums := make([]int64, 3*n)

	for i := 0; i < 3*n; i++ {
		heap.Push(pqLeft, nums[i])
		leftSum += int64(nums[i])
		if pqLeft.Len() > n {
			leftSum -= int64(heap.Pop(pqLeft).(int))
		}
		if pqLeft.Len() == n {
			leftSums[i] = leftSum
		}
	}

	rightSum := int64(0)
	pqRight := &IntMinHeap{}
	heap.Init(pqRight)
	rightSums := make([]int64, 3*n)

	for i := 3*n - 1; i >= 0; i-- {
		heap.Push(pqRight, nums[i])
		rightSum += int64(nums[i])
		if pqRight.Len() > n {
			rightSum -= int64(heap.Pop(pqRight).(int))
		}
		if pqRight.Len() == n {
			rightSums[i] = rightSum
		}
	}

	minDiff := int64(math.MaxInt64)

	for i := n - 1; i < 2*n; i++ {
		minDiff = min(minDiff, leftSums[i]-rightSums[i+1])
	}

	return minDiff
}