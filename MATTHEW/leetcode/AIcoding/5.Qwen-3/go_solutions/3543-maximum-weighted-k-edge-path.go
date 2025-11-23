package main

import (
	"container/heap"
)

type Edge struct {
	to   int
	weight int
}

type MaxHeap []*Edge

func (h MaxHeap) Len() int           { return len(h) }
func (h MaxHeap) Less(i, j int) bool { return h[i].weight > h[j].weight }
func (h MaxHeap) Swap(i, j int)      { h[i], h[j] = h[j], h[i] }

func (h *MaxHeap) Push(x interface{}) {
	*h = append(*h, x.(*Edge))
}

func (h *MaxHeap) Pop() interface{} {
	old := *h
	n := len(old)
	x := old[n-1]
	*h = old[0 : n-1]
	return x
}

func maxWeightedKEdgePath(n int, edges [][]int, k int) int {
	graph := make([][]Edge, n)
	for _, e := range edges {
		u, v, w := e[0], e[1], e[2]
		graph[u] = append(graph[u], Edge{v, w})
		graph[v] = append(graph[v], Edge{u, w})
	}

	visited := make([]bool, n)
	maxHeap := &MaxHeap{}
	heap.Init(maxHeap)

	// Start from node 0
	for _, e := range graph[0] {
		heap.Push(maxHeap, &e)
	}
	visited[0] = true

	totalWeight := 0
	count := 0

	for maxHeap.Len() > 0 && count < k {
		edge := heap.Pop(maxHeap).(*Edge)
		if !visited[edge.to] {
			visited[edge.to] = true
			totalWeight += edge.weight
			count++
			for _, e := range graph[edge.to] {
				heap.Push(maxHeap, &e)
			}
		}
	}

	return totalWeight
}