func restoreArray(adj [][]int) []int {
    n := len(adj)
    graph := make([][]int, n)
    for _, edge := range adj {
        graph[edge[0]] = append(graph[edge[0]], edge[1])
        graph[edge[1]] = append(graph[edge[1]], edge[0])
    }

    visited := make([]bool, n)
    result := make([]int, 0)

    var dfs func(node int)
    dfs = func(node int) {
        visited[node] = true
        result = append(result, node)
        for _, neighbor := range graph[node] {
            if !visited[neighbor] {
                dfs(neighbor)
            }
        }
    }

    dfs(0)
    return result
}