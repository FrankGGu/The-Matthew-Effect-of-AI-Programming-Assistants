func minTime(n int, edges [][]int, hasApple []bool) int {
	graph := make([][]int, n)
	for _, edge := range edges {
		u, v := edge[0], edge[1]
		graph[u] = append(graph[u], v)
		graph[v] = append(graph[v], u)
	}

	var dfs func(node, parent int) int
	dfs = func(node, parent int) int {
		time := 0
		for _, neighbor := range graph[node] {
			if neighbor != parent {
				childTime := dfs(neighbor, node)
				if childTime > 0 || hasApple[neighbor] {
					time += childTime + 2
				}
			}
		}
		return time
	}

	return dfs(0, -1)
}