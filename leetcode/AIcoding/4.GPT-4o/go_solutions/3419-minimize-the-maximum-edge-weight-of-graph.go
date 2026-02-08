package main

import (
	"container/heap"
	"fmt"
	"math"
)

type Edge struct {
	to, weight int
}

type Graph struct {
	adj [][]Edge
}

func NewGraph(n int) *Graph {
	return &Graph{adj: make([][]Edge, n)}
}

func (g *Graph) AddEdge(from, to, weight int) {
	g.adj[from] = append(g.adj[from], Edge{to, weight})
	g.adj[to] = append(g.adj[to], Edge{from, weight})
}

type MinHeap struct {
	items []int
}

func (h *MinHeap) Len() int {
	return len(h.items)
}

func (h *MinHeap) Less(i, j int) bool {
	return h.items[i] < h.items[j]
}

func (h *MinHeap) Swap(i, j int) {
	h.items[i], h.items[j] = h.items[j], h.items[i]
}

func (h *MinHeap) Push(x interface{}) {
	h.items = append(h.items, x.(int))
}

func (h *MinHeap) Pop() interface{} {
	old := h.items
	n := len(old)
	x := old[n-1]
	h.items = old[0 : n-1]
	return x
}

func canMinimizeMaxWeight(graph *Graph, maxWeight int, n int) bool {
	visited := make([]bool, n)
	var dfs func(node int) bool
	dfs = func(node int) bool {
		if node == n-1 {
			return true
		}
		visited[node] = true
		for _, edge := range graph.adj[node] {
			if !visited[edge.to] && edge.weight <= maxWeight {
				if dfs(edge.to) {
					return true
				}
			}
		}
		return false
	}
	return dfs(0)
}

func minimizeMaxEdgeWeight(edges [][]int, n int) int {
	graph := NewGraph(n)
	for _, edge := range edges {
		graph.AddEdge(edge[0], edge[1], edge[2])
	}

	left, right := 0, math.MaxInt32
	for left < right {
		mid := left + (right-left)/2
		if canMinimizeMaxWeight(graph, mid, n) {
			right = mid
		} else {
			left = mid + 1
		}
	}
	return left
}

func main() {
	edges := [][]int{{0, 1, 1}, {1, 2, 2}, {0, 2, 2}}
	n := 3
	result := minimizeMaxEdgeWeight(edges, n)
	fmt.Println(result)
}