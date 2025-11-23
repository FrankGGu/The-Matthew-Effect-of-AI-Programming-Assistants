func timeTakenToMarkAllNodes(time []int, edges [][]int) int {
	n := len(time)
	if n == 0 {
		return 0
	}

	adj := make([][]int, n)
	for _, edge := range edges {
		u, v := edge[0], edge[1]
		adj[u] = append(adj[u], v)
		adj[v] = append(adj[v], u)
	}

	var dfs func(u, parent int) int
	dfs = func(