func gardenNoAdj(n int, paths [][]int) []int {
	adj := make([][]int, n)
	for _, path := range paths {
		u, v := path[0]-1, path[1]-1
		adj[u] = append(adj[u], v)
		adj[v] = append(adj[v], u)
	}

	result := make([]int, n)
	for i := 0; i < n; i++ {
		used := make([]bool, 5)
		for _, neighbor := range adj[i] {
			if result[neighbor] != 0 {
				used[result[neighbor]] = true
			}
		}
		for j := 1; j <= 4; j++ {
			if !used[j] {
				result[i] = j
				break
			}
		}
	}

	return result
}