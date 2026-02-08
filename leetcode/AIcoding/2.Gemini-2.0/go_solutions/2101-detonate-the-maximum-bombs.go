func maximumDetonation(bombs [][]int) int {
	n := len(bombs)
	adj := make([][]int, n)
	for i := 0; i < n; i++ {
		for j := 0; j < n; j++ {
			if i == j {
				continue
			}
			x1, y1, r1 := bombs[i][0], bombs[i][1], bombs[i][2]
			x2, y2 := bombs[j][0], bombs[j][1]
			distSq := (x1-x2)*(x1-x2) + (y1-y2)*(y1-y2)
			if distSq <= r1*r1 {
				adj[i] = append(adj[i], j)
			}
		}
	}

	maxDetonated := 0
	for i := 0; i < n; i++ {
		visited := make([]bool, n)
		count := dfs(i, adj, visited)
		if count > maxDetonated {
			maxDetonated = count
		}
	}

	return maxDetonated
}

func dfs(node int, adj [][]int, visited []bool) int {
	visited[node] = true
	count := 1
	for _, neighbor := range adj[node] {
		if !visited[neighbor] {
			count += dfs(neighbor, adj, visited)
		}
	}
	return count
}