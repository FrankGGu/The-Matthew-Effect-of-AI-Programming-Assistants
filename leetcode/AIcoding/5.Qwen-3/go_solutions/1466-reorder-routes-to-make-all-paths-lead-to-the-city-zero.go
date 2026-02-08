package main

func minReorder(n int, connections [][]int) int {
    graph := make([][]int, n)
    for _, conn := range connections {
        u, v := conn[0], conn[1]
        graph[u] = append(graph[u], v)
        graph[v] = append(graph[v], u)
    }

    visited := make([]bool, n)
    result := 0

    var dfs func(node int, parent int)
    dfs = func(node int, parent int) {
        for _, neighbor := range graph[node] {
            if neighbor == parent {
                continue
            }
            if neighbor != parent {
                result++
            }
            visited[neighbor] = true
            dfs(neighbor, node)
        }
    }

    visited[0] = true
    dfs(0, -1)

    return result
}