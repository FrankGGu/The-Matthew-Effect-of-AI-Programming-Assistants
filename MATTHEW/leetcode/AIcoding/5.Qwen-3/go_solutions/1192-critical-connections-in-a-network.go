package main

func criticalConnections(n int, connections [][]int) [][]int {
    graph := make(map[int][]int)
    for _, conn := range connections {
        u, v := conn[0], conn[1]
        graph[u] = append(graph[u], v)
        graph[v] = append(graph[v], u)
    }

    result := [][]int{}
    visited := make(map[int]bool)
    low := make(map[int]int)
    disc := make(map[int]int)
    time := 0

    var dfs func(int, int)
    dfs = func(u, parent int) {
        visited[u] = true
        time++
        disc[u] = time
        low[u] = time

        for _, v := range graph[u] {
            if v == parent {
                continue
            }
            if !visited[v] {
                dfs(v, u)
                low[u] = min(low[u], low[v])
                if low[v] > disc[u] {
                    result = append(result, []int{u, v})
                }
            } else {
                low[u] = min(low[u], disc[v])
            }
        }
    }

    for i := 0; i < n; i++ {
        if !visited[i] {
            dfs(i, -1)
        }
    }

    return result
}

func min(a, b int) int {
    if a < b {
        return a
    }
    return b
}