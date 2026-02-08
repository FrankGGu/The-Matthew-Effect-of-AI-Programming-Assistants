package main

type Edge struct {
	To     int
	Weight int
}

func dfs(u, parent, currentPathSum int, adj [][]Edge, signalSpeed int, subTreeCounts []int) {
	// Increment the count for the current path sum's remainder.
	subTreeCounts[currentPathSum%signalSpeed]++

	// Recurse for all neighbors of 'u' except 'parent'.
	for _, edge := range adj[u] {
		v := edge.To
		weight := edge.Weight
		if v == parent {
			continue
		}
		dfs(v, u, currentPathSum+weight, adj, signalSpeed, subTreeCounts)
	}
}

func countPairsOfConnectableServers(edges [][]int, signalSpeed int) []int {
	n := len(edges) + 1 // Number of nodes (servers)
	adj := make([][]Edge, n)

	// Build adjacency list from the given edges.
	for _, edge := range edges {
		u, v, weight := edge[0], edge[1], edge[2]
		adj[u] = append(adj[u], Edge{To: v, Weight: weight})
		adj[v] = append(adj[v], Edge{To: u, Weight: weight})
	}

	ans := make([]int, n)

	// Iterate through each node, treating it as the central server 'i'.
	for i := 0; i < n; i++ {
		totalPairsForI := 0
		// prefixCounts stores the accumulated counts of path sums (modulo signalSpeed)
		// from 'i' to nodes in subtrees processed so far.
		prefixCounts := make([]int, signalSpeed)

		// For each neighbor 'j' of 'i', perform a DFS to find path sums in its subtree.
		for _, edge := range adj[i] {
			j := edge.To
			weight := edge.Weight

			// subTreeCounts will store path sum counts for the current subtree rooted at 'j'.
			// These path sums are from 'i' to nodes within j's subtree.
			subTreeCounts := make([]int, signalSpeed)

			// Start DFS from neighbor 'j'. The path sum from 'i' to 'j' is 'weight'.
			// 'i' is passed as the parent to prevent going back up to 'i'.
			dfs(j, i, weight, adj, signalSpeed, subTreeCounts)

			// Now, combine counts from previously processed subtrees (prefixCounts)
			// with counts from the current subtree (subTreeCounts).
			// We are looking for pairs (x, y) where x is in a previous subtree and y is in the current subtree,
			// such that (path(i, x) + path(i, y)) % signalSpeed == 0.
			// Let path(i, x) % signalSpeed = rem1, and path(i, y) % signalSpeed = rem2.
			// We need (rem1 + rem2) % signalSpeed == 0.
			for rem1 := 0; rem1 < signalSpeed; rem1++ {
				// The required rem2 is (signalSpeed - rem1) % signalSpeed.
				// If rem1 is 0, rem2 is 0. If rem1 > 0, rem2 is signalSpeed - rem1.
				rem2 := (signalSpeed - rem1) % signalSpeed
				totalPairsForI += prefixCounts[rem1] * subTreeCounts[rem2]
			}

			// After processing the current subtree 'j', add its counts to prefixCounts
			// for future combinations with subsequent subtrees of 'i'.
			for rem := 0; rem < signalSpeed; rem++ {
				prefixCounts[rem] += subTreeCounts[rem]
			}
		}
		ans[i] = totalPairsForI
	}

	return ans
}