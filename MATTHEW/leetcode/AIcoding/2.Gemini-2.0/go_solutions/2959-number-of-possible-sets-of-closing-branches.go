func numberOfWays(n int, roads [][]int, neededEdges int) int64 {
	adj := make([][]int, n)
	for _, road := range roads {
		u, v := road[0]-1, road[1]-1
		adj[u] = append(adj[u], v)
		adj[v] = append(adj[v], u)
	}

	var ans int64
	for i := 0; i < (1 << n); i++ {
		edges := 0
		for u := 0; u < n; u++ {
			if (i>>u)&1 == 0 {
				continue
			}
			for _, v := range adj[u] {
				if u < v && (i>>v)&1 == 1 {
					edges++
				}
			}
		}
		if edges >= neededEdges {
			ans++
		}
	}
	return ans
}