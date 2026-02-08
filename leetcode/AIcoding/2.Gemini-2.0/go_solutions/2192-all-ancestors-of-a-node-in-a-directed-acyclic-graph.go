func getAncestors(n int, edges [][]int) [][]int {
	graph := make([][]int, n)
	inDegree := make([]int, n)
	for _, edge := range edges {
		from := edge[0]
		to := edge[1]
		graph[from] = append(graph[from], to)
		inDegree[to]++
	}

	result := make([][]int, n)
	for i := 0; i < n; i++ {
		result[i] = []int{}
	}

	for i := 0; i < n; i++ {
		ancestors := make([]bool, n)
		q := []int{i}
		visited := make([]bool, n)
		visited[i] = true

		for len(q) > 0 {
			curr := q[0]
			q = q[1:]

			for _, neighbor := range graph[curr] {
				ancestors[neighbor] = true
				if !visited[neighbor] {
					q = append(q, neighbor)
					visited[neighbor] = true
				}
			}
		}

		for j := 0; j < n; j++ {
			if ancestors[j] {
				result[j] = append(result[j], i)
			}
		}
	}

	return result
}