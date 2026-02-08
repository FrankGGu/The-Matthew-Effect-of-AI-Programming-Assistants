func countSubgraphsForEachDiameter(n int, edges [][]int) []int {
	adj := make([][]int, n)
	for _, edge := range edges {
		u, v := edge[0], edge[1]
		adj[u