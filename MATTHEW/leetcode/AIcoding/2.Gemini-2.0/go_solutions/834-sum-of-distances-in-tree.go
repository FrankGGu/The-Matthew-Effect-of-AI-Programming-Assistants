func sumOfDistancesInTree(n int, edges [][]int) []int {
	adj := make([][]int, n)
	for _, edge := range edges {
		u, v := edge[0], edge[1]
		adj[u] = append(adj[u], v)
		adj[v] = append(adj[v], u)
	}

	count := make([]int, n)
	ans := make([]int, n)

	var dfs func(node, parent int)
	dfs = func(node, parent int) {
		count[node] = 1
		for _, child := range adj[node] {
			if child != parent {
				dfs(child, node)
				count[node] += count[child]
				ans[node] += ans[child] + count[child]
			}
		}
	}

	dfs(0, -1)

	var dfs2 func(node, parent int)
	dfs2 = func(node, parent int) {
		for _, child := range adj[node] {
			if child != parent {
				ans[child] = ans[node] - count[child] + (n - count[child])
				dfs2(child, node)
			}
		}
	}

	dfs2(0, -1)

	return ans
}