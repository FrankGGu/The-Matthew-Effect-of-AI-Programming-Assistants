func magnificentSets(n int, edges [][]int) int {
    graph := make([][]int, n+1)
    for _, edge := range edges {
        graph[edge[0]] = append(graph[edge[0]], edge[1])
        graph[edge[1]] = append(graph[edge[1]], edge[0])
    }

    color := make([]int, n+1)
    var dfs func(node, col int) bool
    dfs = func(node, col int) bool {
        color[node] = col
        for _, neighbor := range graph[node] {
            if color[neighbor] == 0 {
                if !dfs(neighbor, 3-col) {
                    return false
                }
            } else if color[neighbor] == col {
                return false
            }
        }
        return true
    }

    groups := 0
    for i := 1; i <= n; i++ {
        if color[i] == 0 {
            if dfs(i, 1) {
                groups++
            }
        }
    }
    return groups
}