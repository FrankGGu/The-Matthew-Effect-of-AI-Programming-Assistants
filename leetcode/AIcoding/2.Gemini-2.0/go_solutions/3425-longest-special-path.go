func longestSpecialPath(n int, edges [][]int) int {
    graph := make([][]int, n)
    for _, edge := range edges {
        u, v := edge[0], edge[1]
        graph[u] = append(graph[u], v)
        graph[v] = append(graph[v], u)
    }

    maxLen := 0
    for i := 0; i < n; i++ {
        visited := make([]bool, n)
        var dfs func(node int, pathLen int)
        dfs = func(node int, pathLen int) {
            visited[node] = true
            maxLen = max(maxLen, pathLen)

            for _, neighbor := range graph[node] {
                if !visited[neighbor] {
                    dfs(neighbor, pathLen+1)
                }
            }
            visited[node] = false
        }
        dfs(i, 1)
    }

    return maxLen
}

func max(a, b int) int {
    if a > b {
        return a
    }
    return b
}