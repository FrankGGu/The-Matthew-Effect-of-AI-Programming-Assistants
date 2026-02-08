func canFinish(numCourses int, prerequisites [][]int) bool {
	adj := make([][]int, numCourses)
	for _, pre := range prerequisites {
		adj[pre[1]] = append(adj[pre[1]], pre[0])
	}

	visited := make([]int, numCourses) // 0: unvisited, 1: visiting, 2: visited

	for i := 0; i < numCourses; i++ {
		if visited[i] == 0 {
			if !dfs(i, adj, visited) {
				return false
			}
		}
	}

	return true
}

func dfs(node int, adj [][]int, visited []int) bool {
	visited[node] = 1 // Mark as visiting

	for _, neighbor := range adj[node] {
		if visited[neighbor] == 1 { // Cycle detected
			return false
		}
		if visited[neighbor] == 0 { // Unvisited
			if !dfs(neighbor, adj, visited) {
				return false
			}
		}
	}

	visited[node] = 2 // Mark as visited
	return true
}