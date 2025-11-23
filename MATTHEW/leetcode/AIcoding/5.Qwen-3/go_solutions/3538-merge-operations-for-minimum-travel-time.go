package main

func minTimeToTravel(n int, roads [][]int) int {
    graph := make([][]int, n)
    for _, road := range roads {
        u, v, t := road[0], road[1], road[2]
        graph[u] = append(graph[u], v)
        graph[v] = append(graph[v], u)
    }

    visited := make([]bool, n)
    time := 0

    var dfs func(int, int)
    dfs = func(node, parent int) {
        for _, neighbor := range graph[node] {
            if neighbor != parent {
                time += 2
                dfs(neighbor, node)
            }
        }
    }

    dfs(0, -1)
    return time
}