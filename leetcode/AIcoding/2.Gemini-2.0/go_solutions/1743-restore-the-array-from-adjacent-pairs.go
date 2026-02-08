func restoreArray(adjacentPairs [][]int) []int {
	graph := make(map[int][]int)
	for _, pair := range adjacentPairs {
		graph[pair[0]] = append(graph[pair[0]], pair[1])
		graph[pair[1]] = append(graph[1], pair[0])
	}

	start := 0
	for k, v := range graph {
		if len(v) == 1 {
			start = k
			break
		}
	}

	n := len(adjacentPairs) + 1
	res := make([]int, n)
	res[0] = start
	visited := make(map[int]bool)
	visited[start] = true

	for i := 1; i < n; i++ {
		for _, neighbor := range graph[res[i-1]] {
			if !visited[neighbor] {
				res[i] = neighbor
				visited[neighbor] = true
				break
			}
		}
	}

	return res
}