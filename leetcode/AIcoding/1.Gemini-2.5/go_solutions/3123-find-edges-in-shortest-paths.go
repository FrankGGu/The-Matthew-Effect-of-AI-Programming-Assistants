package main

import (
	"container/heap"
	"math"
)

type State struct {
	dist int
	node int
}

type MinHeap []State

func (h MinHeap) Len() int           { return len(h) }
func (h MinHeap) Less(i, j int) bool { return h[i].dist < h[j].dist }
func (h MinHeap) Swap(i, j int)      { h[i], h[j] = h[j], h[i] }

func (h *MinHeap) Push(x interface{}) {
	*h = append(*h, x.(State))
}

func (h *MinHeap) Pop() interface{} {
	old := *h
	n := len(old)
	x := old[n-1]
	*h = old[0 : n-1]
	return x
}

func dijkstra(n int, adj [][]struct{ to, weight int }, startNode int) []int {
	dist := make([]int, n)
	for i := range dist {
		dist[i] = math.MaxInt // Initialize distances to infinity
	}
	dist[startNode] = 0 // Distance to startNode is 0

	pq := &MinHeap{}
	heap.Push(pq, State{dist: 0, node: startNode})

	for pq.Len() > 0 {
		curr := heap.Pop(pq).(State)
		d := curr.dist
		u := curr.node

		// If we found a shorter path to 'u' already, skip this one.
		if d > dist[u] {
			continue
		}

		// Explore neighbors of 'u'
		for _, edge := range adj[u] {
			v := edge.to
			w := edge.weight
			// Check for potential overflow before addition and if a shorter path is found
			if dist[u] != math.MaxInt && dist[u]+w < dist[v] {
				dist[v] = dist[u] + w
				heap.Push(pq, State{dist: dist[v], node: v})
			}
		}
	}
	return dist
}

func findShortestPathEdges(n int, edges [][]int) []int {
	// Build adjacency list for the original graph
	adj := make([][]struct{ to, weight int }, n)
	// Build adjacency list for the reversed graph (for distances from any node to n-1)
	revAdj := make([][]struct{ to, weight int }, n)

	for _, edge := range edges {
		u, v, w := edge[0], edge[1], edge[2]
		adj[u] = append(adj[u], struct{ to, weight int }{v, w})
		revAdj[v] = append(revAdj[v], struct{ to, weight int }{u, w})
	}

	// Calculate shortest distances from node 0 to all other nodes
	dist0 := dijkstra(n, adj, 0)
	// Calculate shortest distances from node n-1 to all other nodes on the reversed graph.
	// This effectively gives shortest distances from any node `i` to node `n-1` in the original graph.
	distN := dijkstra(n, revAdj, n-1)

	var ans []int
	shortestPathLen := dist0[n-1]

	// If node n-1 is unreachable from node 0, no shortest path exists, so no edges.
	if shortestPathLen == math.MaxInt {
		return []int{}
	}

	// Iterate through all original edges to check if they are part of a shortest path.
	for i, edge := range edges {
		u, v, w := edge[0], edge[1], edge[2]

		// An edge (u, v) with weight w is part of a shortest path from 0 to n-1
		// if:
		// 1. u is reachable from 0 (dist0[u] is not MaxInt).
		// 2. v can reach n-1 (distN[v] is not MaxInt).
		// 3. The path length 0 -> u -> v -> n-1 equals the overall shortest path length 0 -> n-1.
		if dist0[u] != math.MaxInt && distN[v] != math.MaxInt && dist0[u]+w+distN[v] == shortestPathLen {
			ans = append(ans, i)
		}
	}

	return ans
}