func countSubtrees(n int, edges [][]int, queries [][]int) []int {
	adj := make([][]int, n)
	for _, edge := range edges {
		u, v := edge[0], edge[1]
		adj[u] = append(adj[u], v)
		adj[v] = append(adj[v], u)
	}

	ans := make([]int, len(queries))
	for i, query := range queries {
		u, v := query[0], query[1]
		tempAdj := make([][]int, n)
		for i := 0; i < n; i++ {
			tempAdj[i] = make([]int, 0)
			for _, neighbor := range adj[i] {
				if (i == u && neighbor == v) || (i == v && neighbor == u) {
					continue
				}
				tempAdj[i] = append(tempAdj[i], neighbor)
			}
		}

		visited := make([]bool, n)
		count := 0
		var dfs func(int)
		dfs = func(node int) {
			visited[node] = true
			count++
			for _, neighbor := range tempAdj[node] {
				if !visited[neighbor] {
					dfs(neighbor)
				}
			}
		}

		dfs(0)
		ans[i] = count
	}

	return ans
}