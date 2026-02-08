func numberOfCoins(n int, edges [][]int, cost []int) []int64 {
	adj := make([][]int, n)
	for _, edge := range edges {
		u, v := edge[0], edge[1]
		adj[u] = append(adj[