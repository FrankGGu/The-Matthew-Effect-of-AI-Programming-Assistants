package main

import (
	"container/heap"
	"math"
)

type Edge struct {
	to     int
	prob   float64
}

type MaxHeap []Edge

func (h MaxHeap) Len() int           { return len(h) }
func (h MaxHeap) Less(i, j int) bool { return h[i].prob > h[j].prob }
func (h MaxHeap) Swap(i, j int)      { h[i], h[j] = h[j], h[i] }

func (h *MaxHeap) Push(x interface{}) {
	*h = append(*h, x.(Edge))
}

func (h *MaxHeap) Pop() interface{} {
	old := *h
	n := len(old)
	x := old[n-1]
	*h = old[0 : n-1]
	return x
}

func maxProbability(n int, edges [][]int, succProb []float64, start int, end int) float64 {
	graph := make(map[int][]Edge)
	for i, edge := range edges {
		graph[edge[0]] = append(graph[edge[0]], Edge{to: edge[1], prob: succProb[i]})
		graph[edge[1]] = append(graph[edge[1]], Edge{to: edge[0], prob: succProb[i]})
	}

	maxHeap := &MaxHeap{}
	heap.Push(maxHeap, Edge{to: start, prob: 1.0})
	probabilities := make([]float64, n)
	probabilities[start] = 1.0

	for maxHeap.Len() > 0 {
		current := heap.Pop(maxHeap).(Edge)
		if current.to == end {
			return current.prob
		}
		for _, edge := range graph[current.to] {
			newProb := current.prob * edge.prob
			if newProb > probabilities[edge.to] {
				probabilities[edge.to] = newProb
				heap.Push(maxHeap, Edge{to: edge.to, prob: newProb})
			}
		}
	}
	return 0.0
}