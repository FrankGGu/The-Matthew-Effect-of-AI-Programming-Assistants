func allPathsSourceTarget(graph [][]int) [][]int {
    var result [][]int
    var path []int
    var dfs func(node int)

    dfs = func(node int) {
        path = append(path, node)
        if node == len(graph)-1 {
            result = append(result, append([]int{}, path...))
        } else {
            for _, neighbor := range graph[node] {
                dfs(neighbor)
            }
        }
        path = path[:len(path)-1]
    }

    dfs(0)
    return result
}