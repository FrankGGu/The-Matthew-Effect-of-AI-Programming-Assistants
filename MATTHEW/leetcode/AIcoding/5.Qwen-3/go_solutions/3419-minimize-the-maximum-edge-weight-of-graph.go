package main

func minScore(n int, roads [][]int) int {
    graph := make(map[int]map[int]int)
    for _, road := range roads {
        u, v, w := road[0], road[1], road[2]
        if _, exists := graph[u]; !exists {
            graph[u] = make(map[int]int)
        }
        if _, exists := graph[v]; !exists {
            graph[v] = make(map[int]int)
        }
        graph[u][v] = w
        graph[v][u] = w
    }

    visited := make(map[int]bool)
    minEdge := 1000000

    var dfs func(int)
    dfs = func(node int) {
        visited[node] = true
        for neighbor := range graph[node] {
            if !visited[neighbor] {
                dfs(neighbor)
            }
            if graph[node][neighbor] < minEdge {
                minEdge = graph[node][neighbor]
            }
        }
    }

    dfs(1)

    return minEdge
}