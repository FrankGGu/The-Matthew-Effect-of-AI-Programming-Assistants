package main

import (
	"container/heap"
)

type Edge struct {
	to     int
	weight int
}

type MinHeap struct {
	edges []Edge
}

func (h *MinHeap) Len() int {
	return len(h.edges)
}

func (h *MinHeap) Less(i, j int) bool {
	return h.edges[i].weight < h.edges[j].weight
}

func (h *MinHeap) Swap(i, j int) {
	h.edges[i], h.edges[j] = h.edges[j], h.edges[i]
}

func (h *MinHeap) Push(x interface{}) {
	h.edges = append(h.edges, x.(Edge))
}

func (h *MinHeap) Pop() interface{} {
	old := h.edges
	n := len(old)
	x := old[n-1]
	h.edges = old[0 : n-1]
	return x
}

func minScore(n int, roads [][]int) int {
	graph := make([][]Edge, n+1)
	for _, road := range roads {
		graph[road[0]] = append(graph[road[0]], Edge{to: road[1], weight: road[2]})
		graph[road[1]] = append(graph[road[1]], Edge{to: road[0], weight: road[2]})
	}

	minHeap := &MinHeap{}
	heap.Init(minHeap)
	heap.Push(minHeap, Edge{to: 1, weight: 1 << 31})

	visited := make([]bool, n+1)
	minScore := 1 << 31

	for minHeap.Len() > 0 {
		current := heap.Pop(minHeap).(Edge)
		if visited[current.to] {
			continue
		}
		visited[current.to] = true
		if current.to == n {
			minScore = min(minScore, current.weight)
		}
		for _, edge := range graph[current.to] {
			if !visited[edge.to] {
				heap.Push(minHeap, Edge{to: edge.to, weight: min(current.weight, edge.weight)})
			}
		}
	}
	return minScore
}

func min(a, b int) int {
	if a < b {
		return a
	}
	return b
}