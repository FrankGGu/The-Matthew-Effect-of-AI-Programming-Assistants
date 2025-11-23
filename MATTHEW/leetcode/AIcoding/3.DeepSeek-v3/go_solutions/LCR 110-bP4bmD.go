func allPathsSourceTarget(graph [][]int) [][]int {
    n := len(graph)
    var res [][]int
    var path []int
    var dfs func(int)
    dfs = func(u int) {
        path = append(path, u)
        if u == n-1 {
            tmp := make([]int, len(path))
            copy(tmp, path)
            res = append(res, tmp)
        } else {
            for _, v := range graph[u] {
                dfs(v)
            }
        }
        path = path[:len(path)-1]
    }
    dfs(0)
    return res
}