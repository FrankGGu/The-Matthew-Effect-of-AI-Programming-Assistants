package main

import "fmt"

func maximumEdgeValueSum(n int, edges [][]int, k int) int64 {
	adj := make([][]int, n)
	for _, edge := range edges {
		u, v := edge[0], edge[1]
		adj[u] = append(adj[u], v)
		adj[v] = append(adj[v], u)
	}

	// dfs(u, p) returns [val0, val1]
	// val0: Maximum sum of edge values in the subtree rooted at 'u',
	//       assuming 'x_u' is chosen such that it effectively contributes 0 to the (x_u + x_parent) % k value.
	// val1: Maximum sum of edge values in the subtree rooted at 'u',
	//       assuming 'x_u' is chosen such that it effectively contributes k-1 to the (x_u + x_parent) % k value.
	// The actual values of x_u are not restricted to 0 or k-1; these are conceptual states for the DP.
	var dfs func(u, p int) [2]int64
	dfs = func(u, p int) [2]int64 {
		currentSum0 := int64(0)
		currentSum1 := int64(0)

		for _, v := range adj[u] {
			if v == p {
				continue
			}
			childRes := dfs(v, u)
			child0 := childRes[0]
			child1 := childRes[1]

			// Case 1: x_u is chosen to effectively contribute 0 to (x_u + x_parent) % k.
			// For the edge (u, v), its value is (0 + x_v) % k.
			// To maximize this:
			//   If x_v is chosen to effectively contribute 0: (0 + 0) % k = 0. Total sum: child0.
			//   If x_v is chosen to effectively contribute k-1: (0 + k-1) % k = k-1. Total sum: child1.
			currentSum0 += max(child0, child1+int64(k-1))

			// Case 2: x_u is chosen to effectively contribute k-1 to (x_u + x_parent) % k.
			// For the edge (u, v), its value is (k-1 + x_v) % k.
			// To maximize this:
			//   If x_v is chosen to effectively contribute 0: (k-1 + 0) % k = k-1. Total sum: child0.
			//   If x_v is chosen to effectively contribute k-1: (k-1 + k-1) % k = (2k-2) % k = k-2. Total sum: child1.
			currentSum1 += max(child0+int64(k-1), child1+int64(k-2))
		}
		return [2]int64{currentSum0, currentSum1}
	}

	// Start DFS from node 0. The parent of the root is -1 (dummy).
	// The root has no parent, so its 'x_root' can be chosen freely to maximize the sum.
	// We take the maximum of the two states for the root.
	result := dfs(0, -1)
	return max(result[0], result[1])
}

func max(a, b int64) int64 {
	if a > b {
		return a
	}
	return b
}