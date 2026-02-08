func validPath(n int, edges [][]int, source int, destination int) bool {
    graph := make([][]int, n)
    for _, edge := range edges {
        graph[edge[0]] = append(graph[edge[0]], edge[1])
        graph[edge[1]] = append(graph[edge[1]], edge[0])
    }

    visited := make([]bool, n)
    var dfs func(int) bool
    dfs = func(node int) bool {
        if node == destination {
            return true
        }
        visited[node] = true
        for _, neighbor := range graph[node] {
            if !visited[neighbor] && dfs(neighbor) {
                return true
            }
        }
        return false
    }

    return dfs(source)
}