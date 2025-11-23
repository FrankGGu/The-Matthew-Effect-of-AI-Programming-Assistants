package main

import (
	"math"
	"sort"
)

type DSU struct {
	parent []int
	count  int // Number of disjoint sets
}

func newDSU(n int) *DSU {
	parent := make([]int, n)
	for i := 0; i < n; i++ {
		parent[i] = i
	}
	return &DSU{parent: parent, count: n}
}

func (d *DSU) find(i int) int {
	if d.parent[i] == i {
		return i
	}
	d.parent[i] = d.find(d.parent[i])
	return d.parent[i]
}

func (d *DSU) union(i, j int) bool {
	rootI := d.find(i)
	rootJ := d.find(j)
	if rootI != rootJ {
		d.parent[rootI] = rootJ
		d.count-- // Decrement the number of disjoint sets
		return true
	}
	return false
}

func calculateMST(n int, edges [][]int, excludeIdx int, includeIdx int) (int, int) {
	dsu := newDSU(n)
	currentMSTWeight := 0
	edgesAdded := 0

	// Handle the special case for n=1 (a single node graph has 0 MST weight and 0 edges)
	if n == 1 {
		return 0, 0
	}

	// Forcefully include an edge if specified
	if includeIdx != -1 {
		edge := edges[includeIdx]
		u, v, w := edge[1], edge[2], edge[0]
		if dsu.union(u, v) {
			currentMSTWeight += w
			edgesAdded = 1
		}
	}

	// Iterate through all edges (sorted by weight)
	for i, edge := range edges {
		// Skip excluded or already included edge
		if i == excludeIdx || i == includeIdx {
			continue
		}
		u, v, w := edge[1], edge[2], edge[0]
		if dsu.union(u, v) {
			currentMSTWeight += w
			edgesAdded++
		}
	}

	// Check if all nodes are connected (dsu.count == 1)
	// A valid MST for n nodes (n > 0) must connect all nodes.
	// If dsu.count != 1, the graph is disconnected, return MAX_INT for weight.
	if dsu.count == 1 {
		return currentMSTWeight, edgesAdded
	}
	return math.MaxInt32, edgesAdded // Graph is disconnected
}

func findCriticalAndPseudoCriticalEdges(n int, edges [][]int) [][]int {
	// Step 1: Prepare edges with original indices
	// Each edge will be [weight, u, v, original_index]
	indexedEdges := make([][]int, len(edges))
	for i, edge := range edges {
		indexedEdges[i] = []int{edge[2], edge[0], edge[1], i} // [w, u, v, original_idx]
	}

	// Step 2: Sort edges by weight in ascending order
	sort.Slice(indexedEdges, func(i, j int) bool {
		return indexedEdges[i][0] < indexedEdges[j][0]
	})

	// Step 3: Calculate the weight of the base MST
	minMSTWeight, _ := calculateMST(n, indexedEdges, -1, -1)

	criticalEdges := []int{}
	pseudoCriticalEdges := []int{}

	// Step 4: Iterate through each edge to determine if it's critical or pseudo-critical
	for i := 0; i < len(indexedEdges); i++ {
		originalIdx := indexedEdges[i][3]

		// Check for Critical Edges:
		// An edge is critical if removing it increases the MST weight or makes the graph disconnected.
		weightWithoutCurrent, _ := calculateMST(n, indexedEdges, i, -1)
		if weightWithoutCurrent > minMSTWeight {
			criticalEdges = append(criticalEdges, originalIdx)
			continue // A critical edge cannot be pseudo-critical
		}

		// Check for Pseudo-Critical Edges:
		// An edge is pseudo-critical if it's not critical and it can be part of *some* MST
		// (i.e., forcing its inclusion results in an MST of the same weight as the base MST).
		weightWithCurrent, _ := calculateMST(n, indexedEdges, -1, i)
		if weightWithCurrent == minMSTWeight {
			pseudoCriticalEdges = append(pseudoCriticalEdges, originalIdx)
		}
	}

	return [][]int{criticalEdges, pseudoCriticalEdges}
}