func minTime(n int, edges [][]int, hasApple []bool) int {
    adj := make([][]int, n)
    for _, e := range edges {
        u, v := e[0], e[1]
        adj[u] = append(adj[u], v)
        adj[v] = append(adj[v], u)
    }

    visited := make([]bool, n)
    var dfs func(int) int
    dfs = func(u int) int {
        visited[u] = true
        total := 0
        for _, v := range adj[u] {
            if !visited[v] {
                time := dfs(v)
                if time > 0 || hasApple[v] {
                    total += time + 2
                }
            }
        }
        return total
    }

    return dfs(0)
}