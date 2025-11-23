func isPossible(n int, edges [][]int) bool {
	adj := make([]map[int]bool, n+1)
	degree := make([]int, n+1)

	for i := 1; i <= n; i++ {
		adj[i] =