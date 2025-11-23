func shortestDistance(n int, edges [][]int, queries [][]int) []int {
	dist := make([][]int, n)
	for i := 0; i < n; i++ {
		dist[i] = make([]int, n)
		for j := 0; j < n; j++ {
			if i == j {
				dist[i][j] = 0
			} else {
				dist[i][j] = 1000000000
			}
		}
	}

	for _, edge := range edges {
		u, v := edge[0], edge[1]
		dist[u][v] = 1
		dist[v][u] = 1
	}

	for k := 0; k < n; k++ {
		for i := 0; i < n; i++ {
			for j := 0; j < n; j++ {
				dist[i][j] = min(dist[i][j], dist[i][k]+dist[k][j])
			}
		}
	}

	result := make([]int, len(queries))
	for i, query := range queries {
		u, v := query[0], query[1]
		if dist[u][v] >= 1000000000 {
			result[i] = -1
		} else {
			result[i] = dist[u][v]
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