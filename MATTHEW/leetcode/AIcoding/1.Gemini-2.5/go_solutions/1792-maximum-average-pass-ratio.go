package main

import (
	"container/heap"
)

type Class struct {
	pass  int
	total int
}

type MaxHeap []*Class

func (h MaxHeap) Len() int { return len(h) }
func (h MaxHeap) Less(i, j int) bool {
	gainI := (float64(h[i].pass+1) / float64(h[i].total+1)) - (float64(h[i].pass) / float64(h[i].total))
	gainJ := (float64(h[j].pass+1) / float64(h[j].total+1)) - (float64(h[j].pass) / float64(h[j].total))
	return gainI > gainJ
}
func (h MaxHeap) Swap(i, j int) { h[i], h[j] = h[j], h[i] }

func (h *MaxHeap) Push(x interface{}) {
	*h = append(*h, x.(*Class))
}

func (h *MaxHeap) Pop() interface{} {
	old := *h
	n := len(old)
	x := old[n-1]
	*h = old[0 : n-1]
	return x
}

func maxAverageRatio(classes [][]int, extraStudents int) float64 {
	h := &MaxHeap{}
	heap.Init(h)

	for _, classArr := range classes {
		c := &Class{pass: classArr[0], total: classArr[1]}
		heap.Push(h, c)
	}

	for i := 0; i < extraStudents; i++ {
		c := heap.Pop(h).(*Class)
		c.pass++
		c.total++
		heap.Push(h, c)
	}

	var sumRatios float64
	for h.Len() > 0 {
		c := heap.Pop(h).(*Class)
		sumRatios += float64(c.pass) / float64(c.total)
	}

	return sumRatios / float64(len(classes))
}