func calcEquation(equations [][]string, values []float64, queries [][]string) []float64 {
    graph := make(map[string]map[string]float64)
    for i, eq := range equations {
        a, b := eq[0], eq[1]
        if graph[a] == nil {
            graph[a] = make(map[string]float64)
        }
        if graph[b] == nil {
            graph[b] = make(map[string]float64)
        }
        graph[a][b] = values[i]
        graph[b][a] = 1.0 / values[i]
    }

    var res []float64
    for _, q := range queries {
        a, b := q[0], q[1]
        visited := make(map[string]bool)
        val := dfs(graph, a, b, visited)
        res = append(res, val)
    }
    return res
}

func dfs(graph map[string]map[string]float64, start, end string, visited map[string]bool) float64 {
    if _, ok := graph[start]; !ok {
        return -1.0
    }
    if start == end {
        return 1.0
    }
    visited[start] = true
    for neighbor, weight := range graph[start] {
        if !visited[neighbor] {
            res := dfs(graph, neighbor, end, visited)
            if res != -1.0 {
                return weight * res
            }
        }
    }
    return -1.0
}