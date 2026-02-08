package main

func calcEquation(equations [][]string, values []float64, queries [][]string) []float64 {
    graph := make(map[string]map[string]float64)
    for i := 0; i < len(equations); i++ {
        a, b := equations[i][0], equations[i][1]
        if _, ok := graph[a]; !ok {
            graph[a] = make(map[string]float64)
        }
        if _, ok := graph[b]; !ok {
            graph[b] = make(map[string]float64)
        }
        graph[a][b] = values[i]
        graph[b][a] = 1.0 / values[i]
    }

    result := make([]float64, len(queries))
    for i := 0; i < len(queries); i++ {
        a, b := queries[i][0], queries[i][1]
        if _, ok := graph[a]; !ok || _, ok := graph[b]; !ok {
            result[i] = -1.0
            continue
        }
        if a == b {
            result[i] = 1.0
            continue
        }
        visited := make(map[string]bool)
        result[i] = dfs(a, b, graph, visited, 1.0)
    }
    return result
}

func dfs(node, target string, graph map[string]map[string]float64, visited map[string]bool, value float64) float64 {
    visited[node] = true
    if node == target {
        return value
    }
    for neighbor, weight := range graph[node] {
        if !visited[neighbor] {
            res := dfs(neighbor, target, graph, visited, value*weight)
            if res != -1.0 {
                return res
            }
        }
    }
    return -1.0
}