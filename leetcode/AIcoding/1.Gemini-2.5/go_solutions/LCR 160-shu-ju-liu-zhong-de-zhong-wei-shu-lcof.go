package main

import (
	"container/heap"
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

func (h IntMaxHeap) Peek() int {
	return h[0]
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

func (h IntMinHeap) Peek() int {
	return h[0]
}

type MedianFinder struct {
	maxHeap *IntMaxHeap
	minHeap *IntMinHeap
}

func Constructor() MedianFinder {
	maxH := &IntMaxHeap{}
	minH := &IntMinHeap{}
	heap.Init(maxH)
	heap.Init(minH)
	return MedianFinder{
		maxHeap: maxH,
		minHeap: minH,
	}
}

func (this *MedianFinder) AddNum(num int) {
	if this.maxHeap.Len() == 0 || num <= this.maxHeap.Peek() {
		heap.Push(this.maxHeap, num)
	} else {
		heap.Push(this.minHeap, num)
	}

	if this.maxHeap.Len() > this.minHeap.Len()+1 {
		heap.Push(this.minHeap, heap.Pop(this.maxHeap))
	} else if this.minHeap.Len() > this.maxHeap.Len() {
		heap.Push(this.maxHeap, heap.Pop(this.minHeap))
	}
}

func (this *MedianFinder) FindMedian() float64 {
	if this.maxHeap.Len() == this.minHeap.Len() {
		return float64(this.maxHeap.Peek()+this.minHeap.Peek()) / 2.0
	}
	return float64(this.maxHeap.Peek())
}