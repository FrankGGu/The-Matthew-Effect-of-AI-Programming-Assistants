func minimumTime(n int, edges [][]int, nodes []int) int64 {
	adj := make([][]int, n)
	for _, edge := range edges {
		u, v := edge[0]-1, edge[1]-1
		adj[u] = append(adj[u], v)
		adj[v] = append(adj[v], u)
	}

	visited := make([]bool, n)
	var dfs func(int, int) int64
	dfs = func(u int, time int) int64 {
		visited[u] = true
		maxTime := int64(time)
		if nodes[u] == 1 {
			maxTime = max(maxTime, int64(time))
		}

		children := 0
		for _, v := range adj[u] {
			if !visited[v] {
				children++
				maxTime = max(maxTime, dfs(v, time+1))
			}
		}

		if nodes[u] == 1 || children > 0 {
			return maxTime
		}

		return int64(0)
	}

	res := dfs(0, 0)

	count := 0
	for i := 0; i < n; i++ {
		visited[i] = false
	}

	var dfs2 func(int, int) int
	dfs2 = func(u int, time int) int {
		visited[u] = true
		children := 0
		for _, v := range adj[u] {
			if !visited[v] {
				children++
			}
		}
		return children
	}

	dfs2(0,0)

	return res * 2
}

func max(a, b int64) int64 {
	if a > b {
		return a
	}
	return b
}