package main

import (
	"container/heap"
	"math"
)

func minRefuelStops(target int, startFuel int, stations [][]int) int {
	stations = append(stations, []int{target, 0})
	n := len(stations)
	h := &maxHeap{}
	dp := make([]int, n)
	dp[0] = startFuel
	count := 0

	for i := 0; i < n; i++ {
		for count < i && dp[count] < stations[i][0] {
			count++
		}
		for count < i && h.Len() > 0 && dp[count] < stations[i][0] {
			dp[count+1] = max(dp[count+1], dp[count]+heap.Pop(h).(int))
			count++
		}
		if i < n-1 {
			heap.Push(h, stations[i][1])
		}
	}

	if dp[n-1] >= target {
		return count
	}

	return -1
}

type maxHeap []int

func (h maxHeap) Len() int           { return len(h) }
func (h maxHeap) Less(i, j int) bool { return h[i] > h[j] }
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

func max(a, b int) int {
	if a > b {
		return a
	}
	return b
}