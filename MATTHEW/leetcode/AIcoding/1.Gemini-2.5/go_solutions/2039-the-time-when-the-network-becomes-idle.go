func networkBecomesIdle(edges [][]int, patience []int) int {
	n := len(patience)
	adj := make([][]int, n)
	for _, edge := range edges {
		u, v := edge[0], edge[1]
		adj[u]