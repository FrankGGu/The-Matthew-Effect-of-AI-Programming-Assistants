func allPathsSourceTarget(graph [][]int) [][]int {
	var result [][]int
	var currentPath []int

	n := len(graph)

	var dfs func(node int)
	dfs = func(node int) {
		currentPath = append(currentPath, node)

		if node == n-1 {
			tempPath := make([]int, len(currentPath))
			copy(tempPath, currentPath)
			result = append(result, tempPath)
		} else {
			for _, neighbor := range graph[node] {
				dfs(neighbor)
			}
		}

		currentPath = currentPath[:len(currentPath)-1]
	}

	dfs(0)

	return result
}