package main

import (
	"container/heap"
	"math"
	"sort"
)

type Worker struct {
	Ratio   float64
	Quality int
}

type MaxHeap []int

func (h MaxHeap) Len() int           { return len(h) }
func (h MaxHeap) Less(i, j int) bool { return h[i] > h[j] } // Max-heap (largest element at top)
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

func mincostToHireWorkers(quality []int, wage []int, k int) float64 {
	n := len(quality)
	workers := make([]Worker, n)
	for i := 0; i < n; i++ {
		workers[i] = Worker{
			Ratio:   float64(wage[i]) / float64(quality[i]),
			Quality: quality[i],
		}
	}

	// Sort workers by their ratio in ascending order
	sort.Slice(workers, func(i, j int) bool {
		return workers[i].Ratio < workers[j].Ratio
	})

	minCost := math.MaxFloat64 // Initialize with a very large number
	currentQualitySum := 0

	// Max-heap to store qualities of the K workers with smallest qualities
	pq := &MaxHeap{}
	heap.Init(pq)

	for i := 0; i < n; i++ {
		currentWorker := workers[i]

		currentQualitySum += currentWorker.Quality
		heap.Push(pq, currentWorker.Quality)

		// If we have more than K workers in our group, remove the one with the largest quality
		// to keep the sum of qualities minimal for the current ratio.
		if pq.Len() > k {
			poppedQuality := heap.Pop(pq).(int)
			currentQualitySum -= poppedQuality
		}

		// Once we have exactly K workers, calculate the cost
		if pq.Len() == k {
			cost := currentWorker.Ratio * float64(currentQualitySum)
			if cost < minCost {
				minCost = cost
			}
		}
	}

	return minCost
}