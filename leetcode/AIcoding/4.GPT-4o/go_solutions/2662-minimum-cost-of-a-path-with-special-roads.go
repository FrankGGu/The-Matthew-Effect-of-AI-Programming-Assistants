package main

import (
	"container/heap"
	"math"
)

type Edge struct {
	to     int
	cost   int
}

type Item struct {
	node  int
	cost  int
}

type PriorityQueue []*Item

func (pq PriorityQueue) Len() int { return len(pq) }
func (pq PriorityQueue) Less(i, j int) bool { return pq[i].cost < pq[j].cost }
func (pq PriorityQueue) Swap(i, j int) { pq[i], pq[j] = pq[j], pq[i] }

func (pq *PriorityQueue) Push(x interface{}) {
	*pq = append(*pq, x.(*Item))
}

func (pq *PriorityQueue) Pop() interface{} {
	old := *pq
	n := len(old)
	item := old[n-1]
	*pq = old[0 : n-1]
	return item
}

func minCost(n int, roads [][]int, start int, end int) int {
	graph := make([][]Edge, n)
	for _, road := range roads {
		graph[road[0]] = append(graph[road[0]], Edge{road[1], road[2]})
		graph[road[1]] = append(graph[road[1]], Edge{road[0], road[2]})
	}

	minCost := make([]int, n)
	for i := range minCost {
		minCost[i] = math.MaxInt
	}
	minCost[start] = 0

	pq := &PriorityQueue{}
	heap.Push(pq, &Item{start, 0})

	for pq.Len() > 0 {
		current := heap.Pop(pq).(*Item)
		node := current.node
		cost := current.cost

		if node == end {
			return cost
		}

		for _, edge := range graph[node] {
			if cost+edge.cost < minCost[edge.to] {
				minCost[edge.to] = cost + edge.cost
				heap.Push(pq, &Item{edge.to, minCost[edge.to]})
			}
		}
	}

	return -1
}