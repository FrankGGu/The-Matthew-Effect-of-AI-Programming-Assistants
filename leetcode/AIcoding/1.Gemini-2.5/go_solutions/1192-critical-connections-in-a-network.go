package main

func criticalConnections(n int, connections [][]int) [][]int {
	adj := make([][]int, n)
	for _, conn := range connections {
		u, v := conn[0], conn[1]
		adj[u] = append(adj[u], v)
		adj[v] = append(adj[v], u)
	}

	disc := make([]int, n) // Discovery time of each node
	low := make([]int, n)  // Lowest discovery time reachable from node u
	for i := range disc {
		disc[i] = -1 // Initialize discovery times to -1 (unvisited)
	}

	var result [][]int
	timer := 0 // Global timer for discovery times

	var dfs func(u, p int)
	dfs = func(u, p int) {
		disc[u] = timer
		low[u] = timer
		timer++

		for _, v := range adj[u] {
			if v == p { // Skip parent in DFS tree
				continue
			}
			if disc[v] == -1 { // v is not visited
				dfs(v, u)
				low[u] = min(low[u], low[v])
				// If the lowest discovery time reachable from v is greater than
				// the discovery time of u, then (u, v) is a bridge.
				if low[v] > disc[u] {
					result = append(result, []int{u, v})
				}
			} else { // v is visited and not parent, so it's a back-edge
				low[u] = min(low[u], disc[v])
			}
		}
	}

	// Iterate over all nodes to handle disconnected components
	for i := 0; i < n; i++ {
		if disc[i] == -1 { // If node i has not been visited, start a DFS from it
			dfs(i, -1) // -1 indicates no parent for the root of a DFS tree
		}
	}

	return result
}

func min(a, b int) int {
	if a < b {
		return a
	}
	return b
}