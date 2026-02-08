package main

import (
	"container/heap"
	"math"
)

type Edge struct {
	to     int
	weight int
}

type Graph struct {
	edges [][]Edge
}

func NewGraph(n int) *Graph {
	return &Graph{edges: make([][]Edge, n)}
}

func (g *Graph) AddEdge(from, to, weight int) {
	g.edges[from] = append(g.edges[from], Edge{to, weight})
}

type Item struct {
	node  int
	cost  int
	index int
}

type MinHeap []Item

func (h MinHeap) Len() int           { return len(h) }
func (h MinHeap) Less(i, j int) bool { return h[i].cost < h[j].cost }
func (h MinHeap) Swap(i, j int)      { h[i], h[j] = h[j], h[i]; h[i].index, h[j].index = i, j }

func (h *MinHeap) Push(x interface{}) {
	n := len(*h)
	item := x.(Item)
	item.index = n
	*h = append(*h, item)
}

func (h *MinHeap) Pop() interface{} {
	old := *h
	n := len(old)
	item := old[n-1]
	*h = old[0 : n-1]
	return item
}

func minCost(graph *Graph, start int, end int) int {
	n := len(graph.edges)
	dist := make([]int, n)
	for i := range dist {
		dist[i] = math.MaxInt32
	}
	dist[start] = 0

	h := &MinHeap{}
	heap.Push(h, Item{start, 0, 0})

	for h.Len() > 0 {
		current := heap.Pop(h).(Item)
		if current.node == end {
			return current.cost
		}
		for _, edge := range graph.edges[current.node] {
			newCost := current.cost + edge.weight
			if newCost < dist[edge.to] {
				dist[edge.to] = newCost
				heap.Push(h, Item{edge.to, newCost, 0})
			}
		}
	}
	return -1
}

func minCostWalk(n int, edges [][]int, start int, end int) int {
	graph := NewGraph(n)
	for _, edge := range edges {
		graph.AddEdge(edge[0], edge[1], edge[2])
		graph.AddEdge(edge[1], edge[0], edge[2])
	}
	return minCost(graph, start, end)
}