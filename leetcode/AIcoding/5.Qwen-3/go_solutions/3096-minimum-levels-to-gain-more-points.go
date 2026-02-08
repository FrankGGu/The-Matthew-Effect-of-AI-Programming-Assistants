package main

func minLevels(n int, roads [][]int) int {
    graph := make([][]int, n)
    for _, road := range roads {
        u, v := road[0], road[1]
        graph[u] = append(graph[u], v)
        graph[v] = append(graph[v], u)
    }

    visited := make([]bool, n)
    var dfs func(int) int
    dfs = func(u int) int {
        visited[u] = true
        res := 0
        for _, v := range graph[u] {
            if !visited[v] {
                res += dfs(v)
            }
        }
        return res + 1
    }

    total := dfs(0)
    visited = make([]bool, n)
    var count int
    var dfs2 func(int, int) int
    dfs2 = func(u, parent int) int {
        visited[u] = true
        res := 0
        for _, v := range graph[u] {
            if v != parent {
                res += dfs2(v, u)
            }
        }
        if res > total-res {
            count++
        }
        return res + 1
    }

    dfs2(0, -1)
    return count
}