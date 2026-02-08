func maxOutput(n int, edges [][]int, price []int) int64 {
    adj := make([][]int, n)
    for _, e := range edges {
        u, v := e[0], e[1]
        adj[u] = append(adj[u], v)
        adj[v] = append(adj[v], u)
    }

    res := 0
    var dfs func(int, int) (int, int)
    dfs = func(u, parent int) (int, int) {
        maxPath1 := price[u]
        maxPath2 := 0
        for _, v := range adj[u] {
            if v == parent {
                continue
            }
            child1, child2 := dfs(v, u)
            res = max(res, maxPath1 + child2)
            res = max(res, maxPath2 + child1)
            maxPath1 = max(maxPath1, child1 + price[u])
            maxPath2 = max(maxPath2, child2 + price[u])
        }
        return maxPath1, maxPath2
    }
    dfs(0, -1)
    return int64(res)
}

func max(a, b int) int {
    if a > b {
        return a
    }
    return b
}