func possibleBipartition(n int, dislikes [][]int) bool {
	graph := make([][]int, n+1)
	for _, dislike := range dislikes {
		u, v := dislike[0], dislike[1]
		graph[u] = append(graph[u], v)
		graph[v] = append(graph[v], u)
	}

	color := make([]int, n+1)

	var dfs func(node int, c int) bool
	dfs = func(node int, c int) bool {
		if color[node] != 0 {
			return color[node] == c
		}
		color[node] = c
		for _, neighbor := range graph[node] {
			if !dfs(neighbor, -c) {
				return false
			}
		}
		return true
	}

	for i := 1; i <= n; i++ {
		if color[i] == 0 {
			if !dfs(i, 1) {
				return false
			}
		}
	}

	return true
}