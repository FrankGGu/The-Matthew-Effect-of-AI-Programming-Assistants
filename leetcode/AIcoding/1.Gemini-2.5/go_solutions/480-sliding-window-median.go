package main

import (
	"container/heap"
)

type minHeap []int

func (h minHeap) Len() int           { return len(h) }
func (h minHeap) Less(i, j int) bool { return h[i] < h[j] } // Min-heap
func (h minHeap) Swap(i, j int)      { h[i], h[j] = h[j], h[i] }
func (h *minHeap) Push(x interface{}) {
	*h = append(*h, x.(int))
}
func (h *minHeap) Pop() interface{} {
	old := *h
	n := len(old)
	x := old[n-1]
	*h = old[0 : n-1]
	return x
}
func (h minHeap) Top() int {
	return h[0]
}

type maxHeap []int

func (h maxHeap) Len() int           { return len(h) }
func (h maxHeap) Less(i, j int) bool { return h[i] > h[j] } // Max-heap
func (h maxHeap) Swap(i, j int)      { h[i], h[j] = h[j], h[i] }
func (h *maxHeap) Push(x interface{}) {
	*h = append(*h, x.(int))
}
func (h *maxHeap) Pop() interface{} {
	old := *h
	n := len(old)
	x := old[n-1]
	*h = old[0 : n-1]
	return x
}
func (h maxHeap) Top() int {
	return h[0]
}

type MedianFinder struct {
	minH    *minHeap
	maxH    *maxHeap
	removed map[int]int // Counts of elements to be lazily removed
}

func NewMedianFinder() *MedianFinder {
	minH := &minHeap{}
	maxH := &maxHeap{}
	heap.Init(minH)
	heap.Init(maxH)
	return &MedianFinder{
		minH:    minH,
		maxH:    maxH,
		removed: make(map[int]int),
	}
}

func (mf *MedianFinder) pruneMinHeap() {
	for mf.minH.Len() > 0 && mf.removed[mf.minH.Top()] > 0 {
		mf.removed[mf.minH.Top()]--
		heap.Pop(mf.minH)
	}
}

func (mf *MedianFinder) pruneMaxHeap() {
	for mf.maxH.Len() > 0 && mf.removed[mf.maxH.Top()] > 0 {
		mf.removed[mf.maxH.Top()]--
		heap.Pop(mf.maxH)
	}
}

func (mf *MedianFinder) Add(num int) {
	if mf.maxH.Len() == 0 || num <= mf.maxH.Top() {
		heap.Push(mf.maxH, num)
	} else {
		heap.Push(mf.minH, num)
	}
	mf.Balance()
}

func (mf *MedianFinder) Remove(num int) {
	mf.removed[num]++
	// No immediate rebalance, it will happen during Balance()
}

func (mf *MedianFinder) Balance() {
	// Prune both heaps until their tops are valid elements
	mf.pruneMaxHeap()
	mf.pruneMinHeap()

	// Rebalance sizes
	if mf.maxH.Len() > mf.minH.Len()+1 {
		val := heap.Pop(mf.maxH).(int)
		heap.Push(mf.minH, val)
	} else if mf.minH.Len() > mf.maxH.Len() {
		val := heap.Pop(mf.minH).(int)
		heap.Push(mf.maxH, val)
	}

	// Prune again, as elements just moved or new tops might be marked for removal
	mf.pruneMaxHeap()
	mf.pruneMinHeap()
}

func (mf *MedianFinder) GetMedian(k int) float64 {
	mf.Balance() // Ensure heaps are balanced and pruned before getting median

	if k%2 == 1 { // Odd number of elements
		return float64(mf.maxH.Top())
	} else { // Even number of elements
		return (float64(mf.maxH.Top()) + float64(mf.minH.Top())) / 2.0
	}
}

func medianSlidingWindow(nums []int, k int) []float64 {
	if k == 0 {
		return []float64{}
	}

	mf := NewMedianFinder()
	result := []float64{}

	for i := 0; i < len(nums); i++ {
		// Add current element
		mf.Add(nums[i])

		// If window is full, calculate median and remove oldest element
		if i >= k-1 {
			result = append(result, mf.GetMedian(k))
			// Remove the element that is now outside the window
			mf.Remove(nums[i-(k-1)])
		}
	}
	return result
}