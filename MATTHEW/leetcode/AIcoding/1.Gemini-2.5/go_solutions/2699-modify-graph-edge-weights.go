package main

import (
	"container/heap"
	"math"
)

type State struct {
	dist int
	node int
}

type priorityQueue []State

func (pq priorityQueue) Len() int { return len(pq) }
func (pq priorityQueue) Less(i, j int) bool {
	return pq[i].dist < pq[j].dist
}
func (pq priorityQueue) Swap(i, j int) {
	pq[i], pq[j] = pq[j], pq[i]
}

func (pq *priorityQueue) Push(x interface{}) {
	item := x.(State)
	*pq = append(*pq, item)
}

func (pq *priorityQueue) Pop() interface{} {
	old := *pq
	n := len(old)
	item := old[n-1]
	*pq = old[0 : n-1]
	return item
}

func dijkstra(n int, adj [][][3]int, currentEdges [][]int, source int) []int {
	dist := make([]int, n)
	for i := range dist {
		dist[i] = math.MaxInt32
	}
	dist[source] = 0

	pq := make(priorityQueue, 0)
	heap.Init(&pq)
	heap.Push(&pq, State{0, source})

	for pq.Len() > 0 {
		curr := heap.Pop(&pq).(State)
		d, u := curr.dist, curr.node

		if d > dist[u] {
			continue
		}

		for _, edgeInfo := range adj[u] {
			v, _, originalEdgeIdx := edgeInfo[0], edgeInfo[1], edgeInfo[2]

            // Use the weight from `currentEdges` for this run
            effectiveWeight := currentEdges[originalEdgeIdx][2]

			// Check for overflow before addition
			if dist[u] != math.MaxInt32 && effectiveWeight != math.MaxInt32 && dist[u] + effectiveWeight < dist[v] {
				dist[v] = dist[u] + effectiveWeight
				heap.Push(&pq, State{dist[v], v})
			}
		}
	}
	return dist
}

func modifyGraphEdgeWeights(n int, edges [][]int, source int, destination int, target int) [][]int {
	// Adjacency list: u -> [v, weight, original_edge_index]
	adj := make([][][3]int, n)
	for i, edge := range edges {
		u, v, w := edge[0], edge[1], edge[2]
		adj[u] = append(adj[u], [3]int{v, w, i})
		adj[v] = append(adj[v], [3]int{u, w, i})
	}

	// Step 1: Calculate shortest path with all -1 edges treated as 1.
	// This gives the minimum possible shortest path length.
	tempEdgesForMinPath := make([][]int, len(edges))
	for i := range edges {
		tempEdgesForMinPath[i] = make([]int, 3)
		copy(tempEdgesForMinPath[i], edges[i])
		if tempEdgesForMinPath[i][2] == -1 {
			tempEdgesForMinPath[i][2] = 1 // Treat all -1 edges as 1
		}
	}

	distMin := dijkstra(n, adj, tempEdgesForMinPath, source)

	// If destination is unreachable or shortest path is already greater than target, it's impossible.
	if distMin[destination] == math.MaxInt32 || distMin[destination] > target {
		return [][]int{}
	}

	// If the shortest path (with all -1 as 1) is already equal to target,
	// then setting all -1 edges to 1 is a valid solution.
	if distMin[destination] == target {
		return tempEdgesForMinPath // tempEdgesForMinPath already has all -1 as 1
	}

	// Step 2: If distMin[destination] < target, we need to increase the path length.
	// We do this by iterating through each original -1 edge, picking one to absorb the difference,
	// and setting all other -1 edges to 1. Then verify with Dijkstra.

	diff := target - distMin[destination]

	// Collect indices of original -1 edges
	minusOneEdgeIndices := []int{}
	for i := range edges {
		if edges[i][2] == -1 {
			minusOneEdgeIndices = append(minusOneEdgeIndices, i)
		}
	}

	// Iterate through each -1 edge to be the "special" edge that absorbs `diff`
	for _, idxToModify := range minusOneEdgeIndices {
		currentModifiedEdges := make([][]int, len(edges))
		for i := range edges {
			currentModifiedEdges[i] = make([]int, 3)
			copy(currentModifiedEdges[i], edges[i])
		}

		// Assign 1 + diff to the chosen -1 edge
		currentModifiedEdges[idxToModify][2] = 1 + diff

		// Assign 1 to all other -1 edges
		for _, otherIdx := range minusOneEdgeIndices {
			if otherIdx != idxToModify {
				currentModifiedEdges[otherIdx][2] = 1
			}
		}

		// Run Dijkstra with this specific assignment
		currentDist := dijkstra(n, adj, currentModifiedEdges, source)

		// If this assignment results in the shortest path being exactly target, return it.
		if currentDist[destination] == target {
			return currentModifiedEdges
		}
	}

	// If no combination of modifying one -1 edge works, it's impossible.
	return [][]int{}
}