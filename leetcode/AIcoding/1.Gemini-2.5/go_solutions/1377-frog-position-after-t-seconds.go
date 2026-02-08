func frogPosition(n int, edges [][]int, t int, target int) float64 {
	adj := make([][]int, n+1)
	for _, edge := range edges {
		u, v := edge[0], edge[1]
		adj[u] = append(adj[u], v