func minEdgeReversals(n int, edges [][]int) []int {
	adj := make([][]int, n)
	rev := make([][]int, n)
	for _, e := range edges {
		adj[e[0]] = append(adj[e[0]], e[1])
		rev[e[0]] = append(rev[e[0]], 0)
		adj[e[1]] = append(adj[e[1]], e[0])
		rev[e[1]] = append(rev[e[1]], 1)
	}

	count := make([]int, n)
	var dfs func(int, int) int
	dfs = func(u int, p int) int {
		c := 0
		for i, v := range adj[u] {
			if v != p {
				c += dfs(v, u)
				c += rev[u][i]
			}
		}
		return c
	}

	count[0] = dfs(0, -1)

	var dfs2 func(int, int)
	dfs2 = func(u int, p int) {
		for i, v := range adj[u] {
			if v != p {
				if rev[u][i] == 0 {
					count[v] = count[u] + 1
				} else {
					count[v] = count[u] - 1
				}
				dfs2(v, u)
			}
		}
	}

	dfs2(0, -1)
	return count
}