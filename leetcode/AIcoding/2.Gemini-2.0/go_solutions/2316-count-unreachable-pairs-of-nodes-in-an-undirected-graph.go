func countUnreachablePairs(n int, edges [][]int) int64 {
	adj := make([][]int, n)
	for _, edge := range edges {
		adj[edge[0]] = append(adj[edge[0]], edge[1])
		adj[edge[1]] = append(adj[edge[1]], edge[0])
	}

	visited := make([]bool, n)
	var components []int

	var dfs func(node int) int
	dfs = func(node int) int {
		visited[node] = true
		count := 1
		for _, neighbor := range adj[node] {
			if !visited[neighbor] {
				count += dfs(neighbor)
			}
		}
		return count
	}

	for i := 0; i < n; i++ {
		if !visited[i] {
			components = append(components, dfs(i))
		}
	}

	var unreachablePairs int64
	totalVisited := 0
	for _, size := range components {
		unreachablePairs += int64(size) * int64(n-totalVisited-size)
		totalVisited += size
	}

	return unreachablePairs
}