package main

func allPathsSourceTarget(graph [][]int) [][]int {
	var result [][]int
	path := []int{0}
	dfs(graph, 0, path, &result)
	return result
}

func dfs(graph [][]int, node int, path []int, result *[][]int) {
	if node == len(graph)-1 {
		*result = append(*result, append([]int{}, path...))
		return
	}
	for _, neighbor := range graph[node] {
		path = append(path, neighbor)
		dfs(graph, neighbor, path, result)
		path = path[:len(path)-1]
	}
}