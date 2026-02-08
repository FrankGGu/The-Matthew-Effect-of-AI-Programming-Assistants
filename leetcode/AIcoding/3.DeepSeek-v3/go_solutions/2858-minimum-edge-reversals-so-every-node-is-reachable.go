func minEdgeReversals(n int, edges [][]int) []int {
    adj := make([][]int, n)
    reverseAdj := make([][]int, n)
    for _, e := range edges {
        u, v := e[0], e[1]
        adj[u] = append(adj[u], v)
        reverseAdj[v] = append(reverseAdj[v], u)
    }

    root := 0
    res := make([]int, n)
    visited := make([]bool, n)
    var dfs func(int)
    dfs = func(u int) {
        visited[u] = true
        for _, v := range adj[u] {
            if !visited[v] {
                res[v] = res[u]
                dfs(v)
            }
        }
        for _, v := range reverseAdj[u] {
            if !visited[v] {
                res[v] = res[u] + 1
                dfs(v)
            }
        }
    }
    dfs(root)

    return res
}