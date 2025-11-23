func countCompleteComponents(n int, edges [][]int) int {
	adj := make([][]int, n)
	for _, edge := range edges {
		u, v := edge[0], edge[1]
		adj[u] = append(adj[u], v)
		adj[v] = append(adj[v], u)
	}

	visited := make([]bool, n)
	count := 0

	for i := 0; i < n; i++ {
		if !visited[i] {
			nodes := 0
			edgesInComponent := 0
			queue := []int{i}
			visited[i] = true
			nodes++

			for len(queue) > 0 {
				u := queue[0]
				queue = queue[1:]

				for _, v := range adj[u] {
					edgesInComponent++
					if !visited[v] {
						visited[v] = true
						queue = append(queue, v)
						nodes++
					}
				}
			}

			edgesInComponent /= 2

			if nodes*(nodes-1)/2 == edgesInComponent {
				count++
			}
		}
	}

	return count
}