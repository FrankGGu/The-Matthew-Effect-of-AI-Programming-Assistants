func isBipartite(graph [][]int) bool {
	n := len(graph)
	colors := make([]int, n)
	for i := 0; i < n; i++ {
		if colors[i] == 0 {
			if !dfs(graph, i, 1, colors) {
				return false
			}
		}
	}
	return true
}

func dfs(graph [][]int, node int, color int, colors []int) bool {
	colors[node] = color
	for _, neighbor := range graph[node] {
		if colors[neighbor] == 0 {
			if !dfs(graph, neighbor, -color, colors) {
				return false
			}
		} else if colors[neighbor] == colors[node] {
			return false
		}
	}
	return true
}