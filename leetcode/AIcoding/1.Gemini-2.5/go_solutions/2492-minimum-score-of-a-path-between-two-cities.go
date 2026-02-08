func minScore(n int, roads [][]int) int {
	adj := make([][][]int, n+1) // adj[u] = [[v1, dist1], [v2, dist2], ...]
	for _, road := range roads {
		u, v, dist := road[