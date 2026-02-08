func allPathsSourceTarget(graph [][]int) [][]int {
	target := len(graph) - 1
	paths := [][]int{}
	var dfs func(node int, path []int)

	dfs = func(node int, path []int) {
		path = append(path, node)
		if node == target {
			newPath := make([]int, len(path))
			copy(newPath, path)
			paths = append(paths, newPath)
			return
		}
		for _, neighbor := range graph[node] {
			dfs(neighbor, path)
		}
	}

	dfs(0, []int{})
	return paths
}