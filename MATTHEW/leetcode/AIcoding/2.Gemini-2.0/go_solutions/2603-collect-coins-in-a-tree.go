func collectTheCoins(coins []int, edges [][]int) int {
	n := len(coins)
	adj := make([][]int, n)
	degree := make([]int, n)
	for _, edge := range edges {
		u, v := edge[0], edge[1]
		adj[u] = append(adj[u], v)
		adj[v] = append(adj[v], u)
		degree[u]++
		degree[v]++
	}

	remaining := n
	for i := 0; i < n; i++ {
		if degree[i] == 1 && coins[i] == 0 {
			degree[i] = 0
			remaining--
		}
	}

	for i := 0; i < n; i++ {
		if degree[i] == 1 {
			for _, neighbor := range adj[i] {
				if degree[neighbor] > 0 {
					degree[i] = 0
					degree[neighbor]--
					remaining--
					break
				}
			}
		}
	}

	adj2 := make([][]int, n)
	for _, edge := range edges {
		u, v := edge[0], edge[1]
		if degree[u] > 0 && degree[v] > 0 {
			adj2[u] = append(adj2[u], v)
			adj2[v] = append(adj2[v], u)
		}
	}

	degree2 := make([]int, n)
	for i := 0; i < n; i++ {
		degree2[i] = len(adj2[i])
	}

	for i := 0; i < n; i++ {
		if degree2[i] == 1 {
			degree2[i] = 0
			remaining--
		}
	}

	for i := 0; i < n; i++ {
		if degree2[i] == 1 {
			remaining--
		}
	}

	if remaining <= 0 {
		return 0
	}

	return 2 * (remaining - 1)
}