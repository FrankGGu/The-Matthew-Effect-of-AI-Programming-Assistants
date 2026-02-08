package main

import (
	"container/heap"
)

type Team struct {
	efficiency int
	speed      int
}

type MaxHeap []Team

func (h MaxHeap) Len() int           { return len(h) }
func (h MaxHeap) Less(i, j int) bool { return h[i].efficiency > h[j].efficiency }
func (h MaxHeap) Swap(i, j int)      { h[i], h[j] = h[j], h[i] }

func (h *MaxHeap) Push(x interface{}) {
	*h = append(*h, x.(Team))
}

func (h *MaxHeap) Pop() interface{} {
	old := *h
	n := len(old)
	x := old[n-1]
	*h = old[0 : n-1]
	return x
}

func maxPerformance(n int, speed []int, efficiency []int, k int) int {
	teams := make([]Team, n)
	for i := 0; i < n; i++ {
		teams[i] = Team{efficiency[i], speed[i]}
	}

	sort.Slice(teams, func(i, j int) bool {
		return teams[i].efficiency > teams[j].efficiency
	})

	h := &MaxHeap{}
	heap.Init(h)

	totalSpeed := 0
	maxPerformance := 0

	for i := 0; i < n; i++ {
		team := teams[i]
		heap.Push(h, team)
		totalSpeed += team.speed

		if h.Len() > k {
			removed := heap.Pop(h).(Team)
			totalSpeed -= removed.speed
		}

		currentPerformance := totalSpeed * team.efficiency
		if currentPerformance > maxPerformance {
			maxPerformance = currentPerformance
		}
	}

	return maxPerformance
}