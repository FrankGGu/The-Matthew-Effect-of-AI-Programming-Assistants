package main

func isBipartite(graph [][]int) bool {
    color := make([]int, len(graph))
    for i := 0; i < len(graph); i++ {
        if color[i] == 0 {
            if !dfs(graph, color, i, 1) {
                return false
            }
        }
    }
    return true
}

func dfs(graph [][]int, color []int, node int, c int) bool {
    if color[node] != 0 {
        return color[node] == c
    }
    color[node] = c
    for _, neighbor := range graph[node] {
        if !dfs(graph, color, neighbor, -c) {
            return false
        }
    }
    return true
}