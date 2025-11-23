package main

import (
	"container/heap"
)

type MinHeap []int

func (h MinHeap) Len() int           { return len(h) }
func (h MinHeap) Less(i, j int) bool { return h[i] < h[j] }
func (h MinHeap) Swap(i, j int)      { h[i], h[j] = h[j], h[i] }

func (h *MinHeap) Push(x interface{}) {
	*h = append(*h, x.(int))
}

func (h *MinHeap) Pop() interface{} {
	old := *h
	n := len(old)
	x := old[n-1]
	*h = old[0 : n-1]
	return x
}

type MaxHeap []int

func (h MaxHeap) Len() int           { return len(h) }
func (h MaxHeap) Less(i, j int) bool { return h[i] > h[j] }
func (h MaxHeap) Swap(i, j int)      { h[i], h[j] = h[j], h[i] }

func (h *MaxHeap) Push(x interface{}) {
	*h = append(*h, x.(int))
}

func (h *MaxHeap) Pop() interface{} {
	old := *h
	n := len(old)
	x := old[n-1]
	*h = old[0 : n-1]
	return x
}

type MedianFinder struct {
	minHeap *MinHeap
	maxHeap *MaxHeap
}

func Constructor() MedianFinder {
	minH := &MinHeap{}
	maxH := &MaxHeap{}
	heap.Init(minH)
	heap.Init(maxH)
	return MedianFinder{
		minHeap: minH,
		maxHeap: maxH,
	}
}

func (mf *MedianFinder) AddNum(num int) {
	heap.Push(mf.maxHeap, num)
	heap.Push(mf.minHeap, heap.Pop(mf.maxHeap))

	if mf.maxHeap.Len() < mf.minHeap.Len() {
		heap.Push(mf.maxHeap, heap.Pop(mf.minHeap))
	}
}

func (mf *MedianFinder) FindMedian() float64 {
	if mf.maxHeap.Len() == 0 {
		return 0.0
	}

	if mf.maxHeap.Len() > mf.minHeap.Len() {
		return float64((*mf.maxHeap)[0])
	} else {
		return float64((*mf.maxHeap)[0]+(*mf.minHeap)[0]) / 2.0
	}
}