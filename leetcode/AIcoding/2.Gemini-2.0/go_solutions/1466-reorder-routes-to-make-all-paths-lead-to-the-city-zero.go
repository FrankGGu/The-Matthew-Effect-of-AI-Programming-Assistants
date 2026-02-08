func minReorder(n int, connections [][]int) int {
	graph := make([][]int, n)
	for _, conn := range connections {
		graph[conn[0]] = append(graph[conn[0]], conn[1]*2)   // Even number means original direction
		graph[conn[1]] = append(graph[conn[1]], conn[0]*2+1) // Odd number means reversed direction
	}

	visited := make([]bool, n)
	count := 0
	queue := []int{0}
	visited[0] = true

	for len(queue) > 0 {
		node := queue[0]
		queue = queue[1:]

		for _, neighborInfo := range graph[node] {
			neighbor := neighborInfo / 2
			if !visited[neighbor] {
				visited[neighbor] = true
				if neighborInfo%2 == 0 {
					count++
				}
				queue = append(queue, neighbor)
			}
		}
	}

	return count
}