package main

func minEdgeReversals(n int, edges [][]int) int {
	adj := make([][]struct{ to, cost int }, n)
	for _, edge := range edges {
		u, v := edge[0], edge[1]
		// Original edge u -> v:
		// To go u -> v, cost is 0.
		adj[u] = append(adj[u], struct{ to, cost int }{v, 0})
		// To go v -> u, we must reverse the original u -> v edge, so cost is 1.
		adj[v] = append(adj[v], struct{ to, cost int }{u, 1})
	}

	var dfs func(u, parent int) int
	dfs = func(u, parent int) int {
		currentReversals := 0
		for _, neighbor := range adj[u] {
			v, cost := neighbor.to, neighbor.cost
			if v == parent {
				continue
			}
			// Add the cost of the edge (u -> v) to reach v from u.
			currentReversals += cost
			// Recursively add the reversals needed in the subtree rooted at v.
			currentReversals += dfs(v, u)
		}
		return currentReversals
	}

	// Start DFS from node 0. The parent of node 0 is considered -1 (non-existent).
	// This DFS calculates the total minimum reversals required to make all nodes
	// reachable from node 0, by traversing a directed spanning tree rooted at 0.
	return dfs(0, -1)
}