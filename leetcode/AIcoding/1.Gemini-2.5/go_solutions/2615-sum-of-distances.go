func sumOfDistancesInTree(n int, edges [][]int) []int {
	adj := make([][]int, n)
	for _, edge := range edges {
		u, v := edge[0], edge[1]
		adj[u] = append(adj[u], v)
		adj[v] = append(adj[v], u)
	}

	ans := make([]int, n)
	count := make([]int, n)

	var dfs1 func(u, p int)
	dfs1 = func(u, p int) {
		count[u] = 1
		for _, v := range adj[u] {
			if v == p {
				continue
			}
			dfs1(v, u)
			count[u] += count[v]
			ans[u] += ans[v] + count[v]
		}
	}

	var dfs2 func(u, p int)
	dfs2 = func(u, p int) {
		for _, v := range adj[u] {
			if v == p {
				continue
			}
			ans[v] = ans[u] - count[v] + (n - count[v])
			dfs2(v, u)
		}
	}

	dfs1(0, -1)
	dfs2(0, -1)

	return ans
}