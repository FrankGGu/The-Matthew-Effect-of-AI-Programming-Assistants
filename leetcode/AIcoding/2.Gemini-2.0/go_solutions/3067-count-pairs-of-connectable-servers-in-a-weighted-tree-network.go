func countPairs(n int, edges [][]int, signalSpeed int) []int {
	adj := make([][]int, n)
	weights := make([][]int, n)
	for i := 0; i < n; i++ {
		adj[i] = []int{}
		weights[i] = []int{}
	}
	for _, edge := range edges {
		u, v, w := edge[0], edge[1], edge[2]
		adj[u] = append(adj[u], v)
		adj[v] = append(adj[v], u)
		weights[u] = append(weights[u], w)
		weights[v] = append(weights[v], w)
	}

	ans := make([]int, n)
	for i := 0; i < n; i++ {
		counts := []int{}
		for j := 0; j < len(adj[i]); j++ {
			count := 0
			var dfs func(node, parent, dist int)
			dfs = func(node, parent, dist int) {
				if dist > 0 && dist%signalSpeed == 0 {
					count++
				}
				for k := 0; k < len(adj[node]); k++ {
					neighbor := adj[node][k]
					if neighbor != parent {
						dfs(neighbor, node, dist+weights[node][k])
					}
				}
			}
			dfs(adj[i][j], i, weights[i][j])
			counts = append(counts, count)
		}

		for j := 0; j < len(counts); j++ {
			for k := j + 1; k < len(counts); k++ {
				ans[i] += counts[j] * counts[k]
			}
		}
	}

	return ans
}