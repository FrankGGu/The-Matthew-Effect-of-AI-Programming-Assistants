func frogPosition(n int, edges [][]int, t int, target int) float64 {
	adj := make([][]int, n+1)
	for _, edge := range edges {
		adj[edge[0]] = append(adj[edge[0]], edge[1])
		adj[edge[1]] = append(adj[edge[1]], edge[0])
	}

	visited := make([]bool, n+1)
	visited[1] = true

	var dfs func(node, time int, prob float64) float64
	dfs = func(node, time int, prob float64) float64 {
		if time == t || len(adj[node]) == 1 && node != 1 {
			if node == target {
				return prob
			}
			return 0
		}

		count := 0
		for _, neighbor := range adj[node] {
			if !visited[neighbor] {
				count++
			}
		}

		if count == 0 {
			if node == target {
				return prob
			}
			return 0
		}

		res := 0.0
		for _, neighbor := range adj[node] {
			if !visited[neighbor] {
				visited[neighbor] = true
				res += dfs(neighbor, time+1, prob/float64(count))
				visited[neighbor] = false
			}
		}
		return res
	}

	return dfs(1, 0, 1.0)
}