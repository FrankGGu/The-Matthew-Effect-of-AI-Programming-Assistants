package main

func calcEquation(equations [][]string, values []float64, queries [][]string) []float64 {
	graph := make(map[string]map[string]float64)

	for i, eq := range equations {
		u, v := eq[0], eq[1]
		val := values[i]

		if _, ok := graph[u]; !ok {
			graph[u] = make(map[string]float64)
		}
		if _, ok := graph[v]; !ok {
			graph[v] = make(map[string]float64)
		}

		graph[u][v] = val
		graph[v][u] = 1.0 / val
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
		results[i] = dfs(start, end, graph, visited)
	}

	return results
}

func dfs(curr string, target string, graph map[string]map[string]float64, visited map[string]bool) float64 {
	if curr == target {
		return 1.0
	}

	visited[curr] = true

	for neighbor, val := range graph[curr] {
		if !visited[neighbor] {
			res := dfs(neighbor, target, graph, visited)
			if res != -1.0 {
				return val * res
			}
		}
	}

	return -1.0
}