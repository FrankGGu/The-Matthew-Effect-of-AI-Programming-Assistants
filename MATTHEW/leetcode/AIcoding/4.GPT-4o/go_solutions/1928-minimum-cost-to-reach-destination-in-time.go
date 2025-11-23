package main

import (
	"container/heap"
	"math"
)

type Edge struct {
	to     int
	time   int
	cost   int
}

type Item struct {
	node   int
	time   int
	cost   int
}

type MinHeap []Item

func (h MinHeap) Len() int           { return len(h) }
func (h MinHeap) Less(i, j int) bool { return h[i].cost < h[j].cost }
func (h MinHeap) Swap(i, j int)      { h[i], h[j] = h[j], h[i] }

func (h *MinHeap) Push(x interface{}) {
	*h = append(*h, x.(Item))
}

func (h *MinHeap) Pop() interface{} {
	old := *h
	n := len(old)
	item := old[n-1]
	*h = old[0 : n-1]
	return item
}

func minCost(n int, edges [][]int, timeLimit int) int {
	graph := make([][]Edge, n)
	for _, edge := range edges {
		graph[edge[0]] = append(graph[edge[0]], Edge{to: edge[1], time: edge[2], cost: edge[3]})
		graph[edge[1]] = append(graph[edge[1]], Edge{to: edge[0], time: edge[2], cost: edge[3]})
	}

	minCost := make([][]int, n)
	for i := range minCost {
		minCost[i] = make([]int, timeLimit+1)
		for j := range minCost[i] {
			minCost[i][j] = math.MaxInt32
		}
	}
	minCost[0][0] = 0

	h := &MinHeap{}
	heap.Push(h, Item{node: 0, time: 0, cost: 0})

	for h.Len() > 0 {
		curr := heap.Pop(h).(Item)

		if curr.node == n-1 {
			return curr.cost
		}

		for _, edge := range graph[curr.node] {
			newTime := curr.time + edge.time
			newCost := curr.cost + edge.cost

			if newTime <= timeLimit && newCost < minCost[edge.to][newTime] {
				minCost[edge.to][newTime] = newCost
				heap.Push(h, Item{node: edge.to, time: newTime, cost: newCost})
			}
		}
	}

	return -1
}