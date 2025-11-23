func eventualSafeNodes(graph [][]int) []int {
	n := len(graph)
	color := make([]int, n)
	var safe []int

	var dfs func(node int) bool
	dfs = func(node int) bool {
		if color[node] > 0 {
			return color[node] == 2
		}

		color[node] = 1

		for _, neighbor := range graph[node] {
			if color[neighbor] == 1 {
				return false
			}
			if color[neighbor] == 0 && !dfs(neighbor) {
				return false
			}
		}

		color[node] = 2
		return true
	}

	for i := 0; i < n; i++ {
		if dfs(i) {
			safe = append(safe, i)
		}
	}

	return safe
}