package main

import (
	"sort"
)

type DSU struct {
	parent       []int
	maxValInComp []int // maxValInComp[i] stores the maximum value of a node in the component whose root is i.
	maxValCount  []int // maxValCount[i] stores the count of nodes that have maxValInComp[i] value, in the component whose root is i.
}

func newDSU(n int, vals []int) *DSU {
	parent := make([]int, n)
	maxValInComp := make([]int, n)
	maxValCount := make([]int, n)
	for i := 0; i < n; i++ {
		parent[i] = i
		maxValInComp[i] = vals[i]
		maxValCount[i] = 1
	}
	return &DSU{parent: parent, maxValInComp: maxValInComp, maxValCount: maxValCount}
}

func (d *DSU) find(i int) int {
	if d.parent[i] == i {
		return i
	}
	d.parent[i] = d.find(d.parent[i])
	return d.parent[i]
}

func numberOfGoodPaths(vals []int, edges [][]int) int {
	n := len(vals)
	adj := make([][]int, n)
	for _, edge := range edges {
		u, v := edge[0], edge[1]
		adj[u] = append(adj[u], v)
		adj[v] = append(adj[v], u)
	}

	// Create a slice of (value, index) pairs and sort them by value
	type Node struct {
		val   int
		index int
	}
	sortedNodes := make([]Node, n)
	for i := 0; i < n; i++ {
		sortedNodes[i] = Node{val: vals[i], index: i}
	}
	sort.Slice(sortedNodes, func(i, j int) bool {
		return sortedNodes[i].val < sortedNodes[j].val
	})

	dsu := newDSU(n, vals)
	ans := n // Each node itself is a good path

	for _, node := range sortedNodes {
		u := node.index
		currentVal := node.val

		// Iterate through neighbors of u
		for _, w := range adj[u] {
			// Only consider neighbors whose values are less than or equal to currentVal.
			// If vals[w] > currentVal, this edge will be processed when 'w' becomes the current node
			// (and 'u' will be its smaller-valued neighbor).
			if vals[w] <= currentVal {
				rootU := dsu.find(u)
				rootW := dsu.find(w)

				if rootU == rootW {
					continue // Already in the same component
				}

				// At this point, dsu.maxValInComp[rootU] must be currentVal
				// because 'u' (with value currentVal) is in its component,
				// and all other nodes processed so far have values <= currentVal.
				// Similarly, dsu.maxValInComp[rootW] must be <= currentVal.

				if dsu.maxValInComp[rootW] == currentVal {
					// If both components (rooted at rootU and rootW) have 'currentVal' as their maximum value,
					// then merging them creates new good paths.
					// The number of new paths is the product of counts of nodes with 'currentVal' in each component.
					ans += dsu.maxValCount[rootU] * dsu.maxValCount[rootW]
					// Merge rootW into rootU (arbitrary choice, could use union by size/rank for optimization)
					dsu.parent[rootW] = rootU
					dsu.maxValCount[rootU] += dsu.maxValCount[rootW]
					// dsu.maxValInComp[rootU] remains currentVal
				} else { // dsu.maxValInComp[rootW] < currentVal
					// rootU's component has currentVal as max, rootW's component has a strictly smaller max.
					// Merge rootW into rootU.
					// The max value and its count for rootU's component remain unchanged
					// as rootW's component does not contribute any nodes with value 'currentVal'.
					dsu.parent[rootW] = rootU
					// dsu.maxValCount[rootU] remains the same.
					// dsu.maxValInComp[rootU] remains currentVal.
				}
			}
		}
	}

	return ans
}