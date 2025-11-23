func reachableNodes(n int, edges [][]int, restricted []int) int {
	restrictedSet := make(map[int]bool)
	for _, r := range restricted {
		restrictedSet[r] = true
	}

	adj := make([][]int, n)
	for _, edge := range edges {
		u, v := edge[0], edge[1]
		adj[u] = append(adj[u], v)
		adj[v] = append(adj[v], u)
	}

	visited := make([]bool, n)
	count := 0
	queue := []int{0}
	visited[0] = true

	for len(queue) > 0 {
		node := queue[0]
		queue = queue[1:]
		count++

		for _, neighbor := range adj[node] {
			if !visited[neighbor] && !restrictedSet[neighbor] {
				visited[neighbor] = true
				queue = append(queue, neighbor)
			}
		}
	}

	return count
}