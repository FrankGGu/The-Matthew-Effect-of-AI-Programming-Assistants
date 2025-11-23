package main

import (
	"container/heap"
	"math"
)

type Edge struct {
	to     int
	weight int
}

type State struct {
	distance int
	node     int
}

type PriorityQueue []State

func (pq PriorityQueue) Len() int { return len(pq) }
func (pq PriorityQueue) Less(i, j int) bool {
	return pq[i].distance < pq[j].distance
}
func (pq PriorityQueue) Swap(i, j int) {
	pq[i], pq[j] = pq[j], pq[i]
}

func (pq *PriorityQueue) Push(x interface{}) {
	item := x.(State)
	*pq = append(*pq, item)
}

func (pq *PriorityQueue) Pop() interface{} {
	old := *pq
	n := len(old)
	item := old[n-1]
	*pq = old[0 : n-1]
	return item
}

func shortestPathInWeightedTree(n int, edges [][]int, startNode int) []int {
	adj := make([][]Edge, n)
	for _, edge := range edges {
		u, v, w := edge[0], edge[1], edge[2]
		adj[u] = append(adj[u], Edge{to: v, weight: w})
		adj[v] = append(adj[v], Edge{to: u, weight: w})
	}

	dist := make([]int, n)
	for i := range dist {
		dist[i] = math.MaxInt32
	}
	dist[startNode] = 0

	pq := make(PriorityQueue, 0)
	heap.Init(&pq)
	heap.Push(&pq, State{distance: 0, node: startNode})

	for pq.Len() > 0 {
		curr := heap.Pop(&pq).(State)
		d, u := curr.distance, curr.node

		if d > dist[u] {
			continue
		}

		for _, edge := range adj[u] {
			v, weight := edge.to, edge.weight
			if dist[u]+weight < dist[v] {
				dist[v] = dist[u] + weight
				heap.Push(&pq, State{distance: dist[v], node: v})
			}
		}
	}

	return dist
}