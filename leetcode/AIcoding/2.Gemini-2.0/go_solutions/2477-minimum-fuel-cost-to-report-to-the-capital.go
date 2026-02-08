func minimumFuelCost(n int, roads [][]int, seats int) int64 {
	graph := make([][]int, n)
	for _, road := range roads {
		a, b := road[0], road[1]
		graph[a] = append(graph[a], b)
		graph[b] = append(graph[b], a)
	}

	var fuel int64
	visited := make([]bool, n)

	var dfs func(int) int
	dfs = func(node int) int {
		visited[node] = true
		people := 1
		for _, neighbor := range graph[node] {
			if !visited[neighbor] {
				people += dfs(neighbor)
			}
		}
		if node != 0 {
			fuel += int64((people + seats - 1) / seats)
		}
		return people
	}

	dfs(0)
	return fuel
}