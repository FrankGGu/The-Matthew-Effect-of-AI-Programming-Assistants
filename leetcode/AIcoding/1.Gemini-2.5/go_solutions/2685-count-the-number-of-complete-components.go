func countCompleteComponents(n int, edges [][]int) int {
	adj := make([][]int, n)
	for _, edge := range edges {
		u, v := edge[0], edge[1]
		adj[u] = append(adj[u], v)
		adj[v] = append(adj[v], u)
	}

	visited := make([]bool, n)
	completeComponentsCount := 0

	for i := 0; i < n; i++ {
		if !visited[i] {
			nodesInComponent := []int{}
			queue := []int{i}
			visited[i] = true

			head := 0
			for head < len(queue) {
				u := queue[head]
				head++
				nodesInComponent = append(nodesInComponent, u)

				for _, v := range adj[u] {
					if !visited[v] {
						visited[v] = true
						queue = append(queue, v)
					}
				}
			}

			V_comp := len(nodesInComponent)
			totalDegreeSum := 0
			for _, node := range nodesInComponent {
				totalDegreeSum += len(adj[node])
			}

			// For a complete graph with V_comp vertices, the sum of degrees is V_comp * (V_comp - 1).
			// This is because each vertex is connected to V_comp - 1 other vertices.
			// The number of edges is V_comp * (V_comp - 1) / 2.
			// The sum of degrees is 2 * (number of edges).
			if totalDegreeSum == V_comp*(V_comp-1) {
				completeComponentsCount++
			}
		}
	}

	return completeComponentsCount
}