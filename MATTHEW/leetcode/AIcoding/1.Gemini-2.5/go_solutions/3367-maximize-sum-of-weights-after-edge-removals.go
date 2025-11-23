package main

import (
	"math"
)

func maximizeSumOfWeights(n int, edges [][]int, weights []int) int64 {
	adj := make([][]int, n)
	for _, edge := range edges {
		u, v := edge[0], edge[1]
		adj[u] = append(adj[u], v)
		adj[v] = append(adj[v], u)
	}

	var totalSum int64
	for _, w := range weights {
		totalSum += int64(w)
	}

	subtreeSum := make([]int64, n)

	var dfs func(u, p int)
	dfs = func(u, p int) {
		subtreeSum[u] = int64(weights[u])
		for _, v := range adj[u] {
			if v == p {
				continue
			}
			dfs(v, u)
			subtreeSum[u] += subtreeSum[v]
		}
	}

	dfs(0, -1) // Start DFS from node 0 (arbitrary root)

	var maxComponentSum int64 = 0

	// We iterate through all possible subtree sums.
	// Each subtreeSum[i] (where i is not the DFS root) represents the sum of one component
	// if the edge connecting i to its parent is removed.
	// The other component will have sum totalSum - subtreeSum[i].
	// The problem asks to "Maximize Sum of Weights after Edge Removals", which is interpreted as
	// maximizing the sum of the larger of the two components resulting from a single edge removal.
	for i := 0; i < n; i++ {
		s1 := subtreeSum[i]

		// A valid split requires two non-empty components.
		// If s1 == totalSum, it means this "component" is the entire tree,
		// and the other component would have sum 0, which is not a valid split.
		// Since weights[i] >= 1, subtreeSum[i] will always be >= 1.
		// Thus, we only need to check against totalSum.
		if s1 == totalSum {
			continue
		}

		s2 := totalSum - s1

		// Update maxComponentSum with the larger of the two component sums (s1 or s2)
		if s1 > maxComponentSum {
			maxComponentSum = s1
		}
		if s2 > maxComponentSum {
			maxComponentSum = s2
		}
	}

	// For n=1, there are no edges to remove. The loop for maxComponentSum will not find any valid splits.
	// In such a case, maxComponentSum remains 0. This is consistent with no edge removal being possible.
	// If n > 1, there is at least one edge, and maxComponentSum will be at least 1.

	return maxComponentSum
}