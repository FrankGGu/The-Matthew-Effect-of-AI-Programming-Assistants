func countPossibleRootNodes(n int, edges [][]int, corrections [][]int, k int) int {
	adj := make([][]int, n)
	for _, edge := range edges {
		u, v := edge[0], edge[1]
		adj[u] = append(adj[u], v)
		adj