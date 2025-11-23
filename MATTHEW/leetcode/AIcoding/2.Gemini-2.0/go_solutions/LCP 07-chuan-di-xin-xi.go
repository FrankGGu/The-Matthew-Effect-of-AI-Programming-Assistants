func numWays(n int, relation [][]int, k int) int {
	adj := make([][]int, n)
	for _, r := range relation {
		adj[r[0]] = append(adj[r[0]], r[1])
	}

	count := 0
	var dfs func(int, int)
	dfs = func(node int, steps int) {
		if steps == k {
			if node == n-1 {
				count++
			}
			return
		}

		for _, neighbor := range adj[node] {
			dfs(neighbor, steps+1)
		}
	}

	dfs(0, 0)
	return count
}