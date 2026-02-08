func calcEquation(equations [][]string, values []float64, queries [][]string) []float64 {
	graph := make(map[string]map[string]float64)

	for i, equation := range equations {
		a, b := equation[0], equation[1]
		value := values[i]

		if _, ok := graph[a]; !ok {
			graph[a] = make(map[string]float64)
		}
		if _, ok := graph[b]; !ok {
			graph[b] = make(map[string]float64)
		}

		graph[a][b] = value
		graph[b][a] = 1.0 / value
	}

	results := make([]float64, len(queries))

	for i, query := range queries {
		start, end := query[0], query[1]

		if _, ok := graph[start]; !ok {
			results[i] = -1.0
			continue
		}

		if _, ok := graph[end]; !ok {
			results[i] = -1.0
			continue
		}

		if start == end {
			results[i] = 1.0
			continue
		}

		visited := make(map[string]bool)
		result := dfs(graph, start, end, visited)
		results[i] = result
	}

	return results
}

func dfs(graph map[string]map[string]float64, start string, end string, visited map[string]bool) float64 {
	visited[start] = true

	if _, ok := graph[start][end]; ok {
		return graph[start][end]
	}

	for neighbor, value := range graph[start] {
		if !visited[neighbor] {
			result := dfs(graph, neighbor, end, visited)
			if result != -1.0 {
				return value * result
			}
		}
	}

	return -1.0
}

func main() {}