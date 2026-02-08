func possibleBipartition(n int, dislikes [][]int) bool {
	adj := make([][]int, n+1)
	for _, dislike := range dislikes {
		u, v := dislike[0], dislike[1]
		adj[u] = append(adj[u], v)
		adj[v