func allPathsSourceTarget(graph [][]int) [][]int {
    n := len(graph)
    res := [][]int{}
    path := []int{0}

    var dfs func(int)
    dfs = func(node int) {
        if node == n-1 {
            tmp := make([]int, len(path))
            copy(tmp, path)
            res = append(res, tmp)
            return
        }
        for _, neighbor := range graph[node] {
            path = append(path, neighbor)
            dfs(neighbor)
            path = path[:len(path)-1]
        }
    }

    dfs(0)
    return res
}