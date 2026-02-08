func calcEquation(equations [][]string, values []float64, queries [][]string) []float64 {
	graph := make(map[string]map[string]float64)

	for i, eq := range equations {
		a, b := eq[0], eq[1]
		val := values[i]

		if _, ok := graph[a]; !ok {
			graph[a] = make(map[string]float64)
		}
		if _, ok := graph[b]; !ok {
			graph[b] = make(map[string]float64)
		}
		graph[a][b] = val
		graph[b][a] = 1.0 / val
	}

	results := make([]float64, len(queries))

	for i, query := range queries {
		startNode, endNode := query[0], query[1]

		if _, ok := graph[startNode]; !ok {
			results[i] = -1.0
			continue
		}
		if _, ok := graph[endNode]; !ok {
			results[i] = -1.0
			continue
		}

		if startNode == endNode {
			results[i] = 1.0
			continue
		}

		visited := make(map[string]bool)
		results[i] = dfs(startNode, endNode, graph, visited)
	}

	return results
}

func dfs(current, target string, graph map[string]map[string]float64, visited map[string]bool) float64 {
	if current == target {
		return 1.0
	}

	visited[current] = true

	for neighbor, value := range graph[current] {
		if !visited[neighbor] {
			res := dfs(neighbor, target, graph, visited)
			if res != -1.0 {
				return value * res
			}
		}
	}

	return -1.0
}