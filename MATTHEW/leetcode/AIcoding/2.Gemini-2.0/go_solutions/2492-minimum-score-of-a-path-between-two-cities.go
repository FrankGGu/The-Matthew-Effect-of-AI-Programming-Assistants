func minScore(n int, roads [][]int) int {
	adj := make(map[int][]struct{ to, dist int })
	for _, road := range roads {
		u, v, d := road[0], road[1], road[2]
		adj[u] = append(adj[u], struct{ to, dist int }{v, d})
		adj[v] = append(adj[v], struct{ to, dist int }{u, d})
	}

	minDist := 10001
	visited := make([]bool, n+1)
	queue := []int{1}
	visited[1] = true

	for len(queue) > 0 {
		curr := queue[0]
		queue = queue[1:]

		for _, neighbor := range adj[curr] {
			minDist = min(minDist, neighbor.dist)
			if !visited[neighbor.to] {
				visited[neighbor.to] = true
				queue = append(queue, neighbor.to)
			}
		}
	}

	return minDist
}

func min(a, b int) int {
	if a < b {
		return a
	}
	return b
}