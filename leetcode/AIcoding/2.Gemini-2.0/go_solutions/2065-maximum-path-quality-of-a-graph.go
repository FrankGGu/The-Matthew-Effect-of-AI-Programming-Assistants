import "math"

func maximalPathQuality(values []int, edges [][]int, maxTime int) int {
	n := len(values)
	adj := make([][]struct{ to, cost int }, n)
	for _, edge := range edges {
		u, v, w := edge[0], edge[1], edge[2]
		adj[u] = append(adj[u], struct{ to, cost int }{v, w})
		adj[v] = append(adj[v], struct{ to, cost int }{u, w})
	}

	maxQuality := 0
	visited := make([]int, n)
	visited[0] = 1

	var dfs func(node, time, quality int)
	dfs = func(node, time, quality int) {
		if node == 0 {
			maxQuality = int(math.Max(float64(maxQuality), float64(quality)))
		}

		for _, neighbor := range adj[node] {
			next := neighbor.to
			cost := neighbor.cost
			if time+cost <= maxTime {
				if visited[next] == 0 {
					visited[next] = 1
					dfs(next, time+cost, quality+values[next])
					visited[next] = 0
				} else {
					dfs(next, time+cost, quality)
				}
			}
		}
	}

	dfs(0, 0, values[0])
	return maxQuality
}