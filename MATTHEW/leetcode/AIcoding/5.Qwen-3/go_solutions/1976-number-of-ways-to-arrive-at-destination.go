package main

import (
	"container/heap"
)

type Edge struct {
	to, cost int
}

type PriorityQueue []*Edge

func (pq PriorityQueue) Len() int { return len(pq) }

func (pq PriorityQueue) Less(i, j int) bool {
	return pq[i].cost < pq[j].cost
}

func (pq PriorityQueue) Swap(i, j int) {
	pq[i], pq[j] = pq[j], pq[i]
}

func (pq *PriorityQueue) Push(x interface{}) {
	*pq = append(*pq, x.(*Edge))
}

func (pq *PriorityQueue) Pop() interface{} {
	old := *pq
	n := len(old)
	item := old[n-1]
	*pq = old[0 : n-1]
	return item
}

func countPaths(n int, roads [][]int) int {
	const MOD = 1000000007
	graph := make([][]Edge, n)
	for _, road := range roads {
		u, v, t := road[0], road[1], road[2]
		graph[u] = append(graph[u], Edge{v, t})
		graph[v] = append(graph[v], Edge{u, t})
	}

	dist := make([]int, n)
	for i := range dist {
		dist[i] = 1<<31 - 1
	}
	dist[0] = 0

	count := make([]int, n)
	count[0] = 1

	pq := make(PriorityQueue, 0)
	heap.Push(&pq, &Edge{0, 0})

	for pq.Len() > 0 {
		curr := heap.Pop(&pq).(*Edge)
		currentNode, currentDist := curr.to, curr.cost

		if currentDist > dist[currentNode] {
			continue
		}

		for _, edge := range graph[currentNode] {
			neighbor, cost := edge.to, edge.cost
			newDist := dist[currentNode] + cost
			if newDist < dist[neighbor] {
				dist[neighbor] = newDist
				count[neighbor] = count[currentNode]
				heap.Push(&pq, &Edge{neighbor, newDist})
			} else if newDist == dist[neighbor] {
				count[neighbor] = (count[neighbor] + count[currentNode]) % MOD
			}
		}
	}

	return count[n-1]
}