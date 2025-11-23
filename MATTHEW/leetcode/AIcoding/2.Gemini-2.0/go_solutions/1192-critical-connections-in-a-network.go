func criticalConnections(n int, connections [][]int) [][]int {
	graph := make([][]int, n)
	for _, conn := range connections {
		u, v := conn[0], conn[1]
		graph[u] = append(graph[u], v)
		graph[v] = append(graph[v], u)
	}

	disc := make([]int, n)
	low := make([]int, n)
	parent := make([]int, n)
	for i := range parent {
		parent[i] = -1
	}
	timer := 0
	result := [][]int{}

	var dfs func(int)
	dfs = func(node int) {
		disc[node] = timer
		low[node] = timer
		timer++

		for _, neighbor := range graph[node] {
			if neighbor == parent[node] {
				continue
			}

			if disc[neighbor] == 0 {
				parent[neighbor] = node
				dfs(neighbor)
				low[node] = min(low[node], low[neighbor])
				if low[neighbor] > disc[node] {
					result = append(result, []int{node, neighbor})
				}
			} else {
				low[node] = min(low[node], disc[neighbor])
			}
		}
	}

	for i := 0; i < n; i++ {
		if disc[i] == 0 {
			dfs(i)
		}
	}

	return result
}

func min(a, b int) int {
	if a < b {
		return a
	}
	return b
}