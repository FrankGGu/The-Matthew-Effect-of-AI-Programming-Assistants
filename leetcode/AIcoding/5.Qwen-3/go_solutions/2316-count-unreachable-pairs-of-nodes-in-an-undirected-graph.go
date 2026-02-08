package main

func countUnreachablePairs(n int, edges [][]int) int {
    graph := make([][]int, n)
    for _, edge := range edges {
        u, v := edge[0], edge[1]
        graph[u] = append(graph[u], v)
        graph[v] = append(graph[v], u)
    }

    visited := make([]bool, n)
    var dfs func(int) int
    dfs = func(node int) int {
        if visited[node] {
            return 0
        }
        visited[node] = true
        size := 1
        for _, neighbor := range graph[node] {
            size += dfs(neighbor)
        }
        return size
    }

    total := 0
    components := []int{}
    for i := 0; i < n; i++ {
        if !visited[i] {
            components = append(components, dfs(i))
        }
    }

    sum := 0
    for _, size := range components {
        total += size * sum
        sum += size
    }

    return total
}