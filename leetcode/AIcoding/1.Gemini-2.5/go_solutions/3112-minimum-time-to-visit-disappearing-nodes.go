package main

import (
	"container/heap"
	"math"
)

type Item struct {
	time int64 // Time to reach the node
	node int   // Node index
}

type PriorityQueue []*Item

func (pq PriorityQueue) Len() int { return len(pq) }

func (pq PriorityQueue) Less(i, j int) bool {
	// We want Pop to give us the lowest time, so we use less than.
	return pq[i].time < pq[j].time
}

func (pq PriorityQueue) Swap(i, j int) {
	pq[i], pq[j] = pq[j], pq[i]
}

func (pq *PriorityQueue) Push(x interface{}) {
	item := x.(*Item)
	*pq = append(*pq, item)
}

func (pq *PriorityQueue) Pop() interface{} {
	old := *pq
	n := len(old)
	item := old[n-1]
	*pq = old[0 : n-1]
	return item
}

func minimumTime(n int, edges [][]int, disappear []int) []int {
	// Adjacency list to represent the graph: adj[u] = [[v, weight], ...]
	adj := make([][][2]int, n)
	for _, edge := range edges {
		u, v, length := edge[0], edge[1], edge[2]
		adj[u] = append(adj[u], [2]int{v, length})
		adj[v] = append(adj[v], [2]int{u, length}) // Graph is undirected
	}

	// ans64 stores the minimum time to reach each node (using int64 for large times)
	ans64 := make([]int64, n)
	for i := range ans64 {
		ans64[i] = math.MaxInt64 // Initialize with infinity
	}

	// Priority queue for Dijkstra's algorithm
	pq := make(PriorityQueue, 0)
	heap.Init(&pq)

	// Start at node 0 with time 0
	ans64[0] = 0
	heap.Push(&pq, &Item{time: 0, node: 0})

	for pq.Len() > 0 {
		item := heap.Pop(&pq).(*Item)
		currentTime := item.time
		currentNode := item.node

		// If we've already found a shorter path to this node, skip this outdated entry.
		if currentTime > ans64[currentNode] {
			continue
		}

		// If the current node has disappeared by the time we arrive,
		// this path is invalid. We cannot use this node to explore further.
		if currentTime >= int64(disappear[currentNode]) {
			continue
		}

		// Explore neighbors
		for _, edge := range adj[currentNode] {
			neighbor := edge[0]
			weight := edge[1]

			newTime := currentTime + int64(weight) // Calculate new time, ensure weight is int64

			// If this new path to neighbor is shorter than what we currently have
			// AND the neighbor has not disappeared by newTime, then update.
			if newTime < ans64[neighbor] && newTime < int64(disappear[neighbor]) {
				ans64[neighbor] = newTime
				heap.Push(&pq, &Item{time: newTime, node: neighbor})
			}
		}
	}

	// Convert unreachable nodes (math.MaxInt64) to -1 and cast to int for the final result.
	ans := make([]int, n)
	for i := range ans64 {
		if ans64[i] == math.MaxInt64 {
			ans[i] = -1
		} else {
			ans[i] = int(ans64[i])
		}
	}

	return ans
}