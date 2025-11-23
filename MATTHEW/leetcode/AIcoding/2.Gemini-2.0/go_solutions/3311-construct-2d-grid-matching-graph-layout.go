func construct2DArray(n int, edges [][]int) [][]int {
	adj := make([][]int, n)
	for _, edge := range edges {
		u, v := edge[0], edge[1]
		adj[u] = append(adj[u], v)
		adj[v] = append(adj[v], u)
	}

	grid := make([][]int, n)
	for i := range grid {
		grid[i] = make([]int, 2)
	}

	visited := make([]bool, n)
	var dfs func(int, int, int) bool
	dfs = func(u int, x int, y int) bool {
		visited[u] = true
		grid[u][0] = x
		grid[u][1] = y

		for _, v := range adj[u] {
			if !visited[v] {
				if !dfs(v, y, x) {
					return false
				}
			} else {
				if grid[v][0] == x && grid[v][1] == y {
					return false
				}
			}
		}
		return true
	}

	for i := 0; i < n; i++ {
		if !visited[i] {
			if !dfs(i, 0, 0) {
				return [][]int{}
			}
		}
	}

	return grid
}