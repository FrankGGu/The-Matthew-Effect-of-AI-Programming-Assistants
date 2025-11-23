package main

func reachableNodes(n int, edges [][]int, restricted []int) int {
    graph := make(map[int][]int)
    for _, edge := range edges {
        u, v := edge[0], edge[1]
        graph[u] = append(graph[u], v)
        graph[v] = append(graph[v], u)
    }

    restrictedSet := make(map[int]bool)
    for _, node := range restricted {
        restrictedSet[node] = true
    }

    visited := make(map[int]bool)
    var dfs func(int) int
    dfs = func(node int) int {
        if visited[node] || restrictedSet[node] {
            return 0
        }
        visited[node] = true
        count := 1
        for _, neighbor := range graph[node] {
            count += dfs(neighbor)
        }
        return count
    }

    return dfs(0)
}