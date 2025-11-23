package main

import "fmt"

func calcEquation(equations [][]string, values []float64, queries [][]string) []float64 {
    graph := make(map[string]map[string]float64)

    for i, eq := range equations {
        if _, ok := graph[eq[0]]; !ok {
            graph[eq[0]] = make(map[string]float64)
        }
        if _, ok := graph[eq[1]]; !ok {
            graph[eq[1]] = make(map[string]float64)
        }
        graph[eq[0]][eq[1]] = values[i]
        graph[eq[1]][eq[0]] = 1 / values[i]
    }

    results := make([]float64, len(queries))
    for i, query := range queries {
        results[i] = dfs(graph, query[0], query[1], make(map[string]bool))
    }
    return results
}

func dfs(graph map[string]map[string]float64, start, end string, visited map[string]bool) float64 {
    if _, ok := graph[start]; !ok {
        return -1.0
    }
    if start == end {
        return 1.0
    }
    visited[start] = true
    for neighbor, value := range graph[start] {
        if visited[neighbor] {
            continue
        }
        res := dfs(graph, neighbor, end, visited)
        if res != -1.0 {
            return value * res
        }
    }
    return -1.0
}

func main() {
    equations := [][]string{{"a", "b"}, {"b", "c"}}
    values := []float64{2.0, 3.0}
    queries := [][]string{{"a", "c"}, {"b", "a"}, {"a", "e"}, {"a", "a"}, {"x", "x"}}
    result := calcEquation(equations, values, queries)
    fmt.Println(result)
}