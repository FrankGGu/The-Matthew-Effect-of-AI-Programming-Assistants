package main

import (
	"container/heap"
	"sort"
)

type Engineer struct {
	speed      int
	efficiency int
}

type IntHeap []int

func (h IntHeap) Len() int           { return len(h) }
func (h IntHeap) Less(i, j int) bool { return h[i] < h[j] } // Min-heap
func (h IntHeap) Swap(i, j int)      { h[i], h[j] = h[j], h[i] }

func (h *IntHeap) Push(x interface{}) {
	*h = append(*h, x.(int))
}

func (h *IntHeap) Pop() interface{} {
	old := *h
	n := len(old)
	x := old[n-1]
	*h = old[0 : n-1]
	return x
}

func maxPerformance(n int, speed []int, efficiency []int, k int) int64 {
	engineers := make([]Engineer, n)
	for i := 0; i < n; i++ {
		engineers[i] = Engineer{speed: speed[i], efficiency: efficiency[i]}
	}

	sort.Slice(engineers, func(i, j int) bool {
		return engineers[i].efficiency > engineers[j].efficiency
	})

	minHeap := &IntHeap{}
	heap.Init(minHeap)

	var currentSpeedSum int64
	var maxPerf int64
	const MOD int64 = 1e9 + 7

	for _, eng := range engineers {
		currentSpeedSum += int64(eng.speed)
		heap.Push(minHeap, eng.speed)

		if minHeap.Len() > k {
			removedSpeed := heap.Pop(minHeap).(int)
			currentSpeedSum -= int64(removedSpeed)
		}

		currentPerf := currentSpeedSum * int64(eng.efficiency)
		if currentPerf > maxPerf {
			maxPerf = currentPerf
		}
	}

	return maxPerf % MOD
}