package main

func minScore(n int, edges [][]int) int {
    graph := make(map[int][]int)
    for _, edge := range edges {
        u, v := edge[0], edge[1]
        graph[u] = append(graph[u], v)
        graph[v] = append(graph[v], u)
    }

    parent := make(map[int]int)
    visited := make(map[int]bool)

    var dfs func(int, int)
    dfs = func(u, p int) {
        parent[u] = p
        visited[u] = true
        for _, v := range graph[u] {
            if !visited[v] {
                dfs(v, u)
            }
        }
    }

    dfs(1, -1)

    color := make(map[int]int)
    colorCount := make(map[int]int)
    color[1] = 0

    for i := 2; i <= n; i++ {
        c := 0
        u := i
        for parent[u] != -1 {
            u = parent[u]
            c++
        }
        color[i] = c
        colorCount[c]++
    }

    minScore := n
    for _, count := range colorCount {
        if count < minScore {
            minScore = count
        }
    }

    return minScore
}