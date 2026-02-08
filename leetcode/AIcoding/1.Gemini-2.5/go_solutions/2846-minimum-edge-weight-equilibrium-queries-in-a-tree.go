package main

func dfs(u, p, d int, adj [][]struct{to, weight int}, depth []int, parent [][]int, freqOnPath [][][27]int, currentMaxLogN int) {
	depth[u] = d
	parent[u][0] = p

	// Precompute 2^k ancestors and their path frequencies using binary lifting
	for k := 1; k < currentMaxLogN; k++ {
		if parent[u][k-1] != -1 {
			parent[u][k] = parent[parent[u][k-1]][k-1]
			// Combine frequencies from u to parent[u][k-1] and from parent[u][k-1] to parent[u][k]
			for w := 1; w <= 26; w++ {
				freqOnPath[u][k][w] = freqOnPath[u][k-1][w] + freqOnPath[parent[u][k-1]][k-1][w]
			}
		} else {
			parent[u][k] = -1 // No 2^k-th ancestor
		}
	}

	for _, edge := range adj[u] {
		v := edge.to
		w := edge.weight
		if v == p {
			continue
		}
		// Store the frequency for the direct edge (v, u)
		freqOnPath[v][0][w] = 1
		dfs(v, u, d+1, adj, depth, parent, freqOnPath, currentMaxLogN)
	}
}

func getLCA(u, v int, depth []int, parent [][]int, currentMaxLogN int) int {
	// Ensure u is deeper or at the same depth as v
	if depth[u] < depth[v] {
		u, v = v, u
	}

	// Lift u to the same depth as v
	for k := currentMaxLogN - 1; k >= 0; k-- {
		if parent[u][k] != -1 && depth[parent[u][k]] >= depth[v] {
			u = parent[u][k]
		}
	}

	if u == v {
		return u
	}

	// Lift u and v simultaneously until their parents are the LCA
	for k := currentMaxLogN - 1; k >= 0; k-- {
		if parent[u][k] != -1 && parent[v][k] != -1 && parent[u][k] != parent[v][k] {
			u = parent[u][k]
			v = parent[v][k]
		}
	}
	return parent[u][0]
}

func solveQuery(u, v int, depth []int, parent [][]int, freqOnPath [][][27]int, currentMaxLogN int) int {
	lca := getLCA(u, v, depth, parent, currentMaxLogN)

	pathLen := depth[u] + depth[v] - 2*depth[lca]
	if pathLen == 0 { // u and v are the same node, no edges on path
		return 0
	}

	currentFreqs := make([]int, 27) // Frequencies of weights 1-26 on the path u-v

	// Helper function to add frequencies from a node up to a target depth (exclusive)
	addPathFreqs := func(node, targetDepth int) {
		for k := currentMaxLogN - 1; k >= 0; k-- {
			if parent[node][k] != -1 && depth[parent[node][k]] >= targetDepth {
				for w := 1; w <= 26; w++ {
					currentFreqs[w] += freqOnPath[node][k][w]
				}
				node = parent[node][k]
			}
		}
	}

	addPathFreqs(u, depth[lca])
	addPathFreqs(v, depth[lca])

	minChanges := pathLen
	for w := 1; w <= 26; w++ {
		// Changes needed if we want all edges to be weight 'w'
		changes := pathLen - currentFreqs[w]
		if changes < minChanges {
			minChanges = changes
		}
	}
	return minChanges
}

func minEdgeWeightEquilibriumQueries(n int, edges [][]int, queries [][]int) []int {
	// Calculate currentMaxLogN for binary lifting.
	// currentMaxLogN is the smallest integer k such that 2^k >= n.
	var currentMaxLogN int
	for 1<<currentMaxLogN <= n {
		currentMaxLogN++
	}

	adj := make([][]struct{to, weight int}, n+1)
	for _, edge := range edges {
		u, v, w := edge[0], edge[1], edge[2]
		adj[u] = append(adj[u], struct{to, weight int}{v, w})
		adj[v] = append(adj[v], struct{to, weight int}{u, w})
	}

	depth := make([]int, n+1)
	parent := make([][]int, n+1)
	for i := range parent {
		parent[i] = make([]int, currentMaxLogN)
		for j := range parent[i] {
			parent[i][j] = -1 // Initialize parent pointers to -1 (null)
		}
	}

	// freqOnPath[node][k][weight] stores the count of 'weight' on the path
	// from 'node' to its 2^k-th ancestor (exclusive of the ancestor itself).
	freqOnPath := make([][][27]int, n+1)
	for i := range freqOnPath {
		freqOnPath[i] = make([][27]int, currentMaxLogN)
	}

	// Perform DFS starting from node 1 (root), parent -1, depth 0
	dfs(1, -1, 0, adj, depth, parent, freqOnPath, currentMaxLogN)

	results := make([]int, len(queries))
	for i, q := range queries {
		results[i] = solveQuery(q[0], q[1], depth, parent, freqOnPath, currentMaxLogN)
	}

	return results
}