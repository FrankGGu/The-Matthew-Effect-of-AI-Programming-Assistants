func eventualSafeNodes(graph [][]int) []int {
    n := len(graph)
    color := make([]int, n)
    var res []int

    for i := 0; i < n; i++ {
        if dfs(graph, color, i) {
            res = append(res, i)
        }
    }
    return res
}

func dfs(graph [][]int, color []int, node int) bool {
    if color[node] > 0 {
        return color[node] == 2
    }
    color[node] = 1
    for _, neighbor := range graph[node] {
        if color[neighbor] == 2 {
            continue
        }
        if color[neighbor] == 1 || !dfs(graph, color, neighbor) {
            return false
        }
    }
    color[node] = 2
    return true
}