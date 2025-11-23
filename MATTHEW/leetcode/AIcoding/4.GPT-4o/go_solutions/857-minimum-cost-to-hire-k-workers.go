package main

import (
	"container/heap"
	"sort"
)

type Worker struct {
	quality int
	wage    int
}

type MinHeap []Worker

func (h MinHeap) Len() int           { return len(h) }
func (h MinHeap) Less(i, j int) bool { return h[i].quality < h[j].quality }
func (h MinHeap) Swap(i, j int)      { h[i], h[j] = h[j], h[i] }

func (h *MinHeap) Push(x interface{}) {
	*h = append(*h, x.(Worker))
}

func (h *MinHeap) Pop() interface{} {
	old := *h
	n := len(old)
	x := old[n-1]
	*h = old[0 : n-1]
	return x
}

func minCostToHireWorkers(quality []int, wage []int, K int) float64 {
	n := len(quality)
	workers := make([]Worker, n)
	for i := 0; i < n; i++ {
		workers[i] = Worker{quality: quality[i], wage: wage[i]}
	}
	sort.Slice(workers, func(i, j int) bool {
		return float64(workers[i].wage)/float64(workers[i].quality) < float64(workers[j].wage)/float64(workers[j].quality)
	})

	h := &MinHeap{}
	totalQuality := 0
	minCost := float64(1<<63 - 1)

	for _, worker := range workers {
		heap.Push(h, worker)
		totalQuality += worker.quality
		if h.Len() > K {
			totalQuality -= heap.Pop(h).(Worker).quality
		}
		if h.Len() == K {
			cost := float64(totalQuality) * float64(worker.wage) / float64(worker.quality)
			if cost < minCost {
				minCost = cost
			}
		}
	}

	return minCost
}