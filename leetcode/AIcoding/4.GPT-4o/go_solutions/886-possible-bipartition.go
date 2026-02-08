func possibleBipartition(n int, dislikes [][]int) bool {
    graph := make([][]int, n+1)
    for _, pair := range dislikes {
        graph[pair[0]] = append(graph[pair[0]], pair[1])
        graph[pair[1]] = append(graph[pair[1]], pair[0])
    }

    color := make([]int, n+1)

    var dfs func(node, c int) bool
    dfs = func(node, c int) bool {
        if color[node] != 0 {
            return color[node] == c
        }
        color[node] = c
        for _, neighbor := range graph[node] {
            if !dfs(neighbor, -c) {
                return false
            }
        }
        return true
    }

    for i := 1; i <= n; i++ {
        if color[i] == 0 && !dfs(i, 1) {
            return false
        }
    }

    return true
}