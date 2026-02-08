package main

func minScore(n int, roads [][]int) int {
    graph := make(map[int][]int)
    for _, road := range roads {
        u, v, score := road[0], road[1], road[2]
        if _, exists := graph[u]; !exists {
            graph[u] = []int{}
        }
        if _, exists := graph[v]; !exists {
            graph[v] = []int{}
        }
        graph[u] = append(graph[u], v)
        graph[v] = append(graph[v], u)
    }

    visited := make(map[int]bool)
    minScore := 1000000

    var dfs func(int)
    dfs = func(node int) {
        visited[node] = true
        for _, neighbor := range graph[node] {
            if !visited[neighbor] {
                dfs(neighbor)
            }
        }
    }

    for i := 1; i <= n; i++ {
        if !visited[i] {
            dfs(i)
        }
    }

    for _, road := range roads {
        if visited[road[0]] && visited[road[1]] {
            if road[2] < minScore {
                minScore = road[2]
            }
        }
    }

    return minScore
}