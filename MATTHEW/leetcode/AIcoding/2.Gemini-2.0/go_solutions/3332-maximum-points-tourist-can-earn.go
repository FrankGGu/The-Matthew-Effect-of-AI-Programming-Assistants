func maximumPoints(edges [][]int, tourists int, locations []int) int {
	n := len(locations)
	graph := make([][]int, n)
	for _, edge := range edges {
		u, v := edge[0], edge[1]
		graph[u-1] = append(graph[u-1], v-1)
		graph[v-1] = append(graph[v-1], u-1)
	}

	memo := make([][]int, n)
	for i := range memo {
		memo[i] = make([]int, tourists+1)
		for j := range memo[i] {
			memo[i][j] = -1
		}
	}

	var dfs func(int, int, int, []bool) int
	dfs = func(node int, points int, remainingTourists int, visited []bool) int {
		if remainingTourists < 0 {
			return -1000000000
		}

		if memo[node][remainingTourists] != -1 {
			return memo[node][remainingTourists]
		}

		visited[node] = true
		maxPoints := locations[node]
		if remainingTourists > 0 {
			maxPoints += points
		}

		best := maxPoints
		for _, neighbor := range graph[node] {
			if !visited[neighbor] {
				nextVisited := make([]bool, n)
				copy(nextVisited, visited)
				neighborPoints := dfs(neighbor, points, remainingTourists-1, nextVisited)
				best = max(best, neighborPoints)
			}
		}

		memo[node][remainingTourists] = best
		return best
	}

	visited := make([]bool, n)
	return dfs(0, 0, tourists, visited)
}

func max(a, b int) int {
	if a > b {
		return a
	}
	return b
}