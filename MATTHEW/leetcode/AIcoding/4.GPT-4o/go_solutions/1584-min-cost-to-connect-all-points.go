package main

import "container/heap"

type Edge struct {
	u, v, weight int
}

type MinHeap []Edge

func (h MinHeap) Len() int           { return len(h) }
func (h MinHeap) Less(i, j int) bool { return h[i].weight < h[j].weight }
func (h MinHeap) Swap(i, j int)      { h[i], h[j] = h[j], h[i] }

func (h *MinHeap) Push(x interface{}) {
	*h = append(*h, x.(Edge))
}

func (h *MinHeap) Pop() interface{} {
	old := *h
	n := len(old)
	x := old[n-1]
	*h = old[0 : n-1]
	return x
}

func minCostConnectPoints(points [][]int) int {
	n := len(points)
	if n <= 1 {
		return 0
	}

	h := &MinHeap{}
	heap.Init(h)
	visited := make([]bool, n)
	visited[0] = true
	count := 1
	totalCost := 0

	for count < n {
		for i := 0; i < n; i++ {
			if visited[i] {
				for j := 0; j < n; j++ {
					if !visited[j] {
						weight := abs(points[i][0]-points[j][0]) + abs(points[i][1]-points[j][1])
						heap.Push(h, Edge{i, j, weight})
					}
				}
			}
		}

		for h.Len() > 0 {
			edge := heap.Pop(h).(Edge)
			if !visited[edge.v] {
				visited[edge.v] = true
				totalCost += edge.weight
				count++
				break
			}
		}
	}

	return totalCost
}

func abs(x int) int {
	if x < 0 {
		return -x
	}
	return x
}