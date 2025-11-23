func isBipartite(graph [][]int) bool {
	n := len(graph)
	colors := make([]int, n) // 0: uncolored, 1: color A, -1: color B

	for i := 0; i < n; i++ {
		if colors[i] == 0 { // Node i is uncolored, start BFS from here
			queue := []int{i}
			colors[i] = 1 // Assign initial color A

			for len(queue) > 0 {
				curr := queue[0]
				queue = queue[1:]
				currColor := colors[curr]
				nextColor := -currColor // Opposite color

				for _, neighbor := range graph[curr] {
					if colors[neighbor] == 0 { // Neighbor is uncolored
						colors[neighbor] = nextColor
						queue = append(queue, neighbor)
					} else if colors[neighbor] == currColor { // Neighbor has the same color as current node
						return false // Not bipartite
					}
					// If colors[neighbor] == nextColor, it's consistent, do nothing
				}
			}
		}
	}

	return true // All connected components checked and found to be bipartite
}