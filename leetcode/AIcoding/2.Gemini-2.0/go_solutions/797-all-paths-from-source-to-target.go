func allPathsSourceTarget(graph [][]int) [][]int {
	n := len(graph)
	result := [][]int{}
	path := []int{0}

	var dfs func(node int)
	dfs = func(node int) {
		if node == n-1 {
			temp := make([]int, len(path))
			copy(temp, path)
			result = append(result, temp)
			return
		}

		for _, neighbor := range graph[node] {
			path = append(path, neighbor)
			dfs(neighbor)
			path = path[:len(path)-1]
		}
	}

	dfs(0)
	return result
}