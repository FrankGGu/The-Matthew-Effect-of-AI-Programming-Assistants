func mostProfitablePath(edges [][]int, bob int, amount []int) int {
    n := len(edges) + 1
    adj := make([][]int, n)
    for _, e := range edges {
        u, v := e[0], e[1]
        adj[u] = append(adj[u], v)
        adj[v] = append(adj[v], u)
    }

    parent := make([]int, n)
    depth := make([]int, n)
    var dfs func(u, p, d int)
    dfs = func(u, p, d int) {
        parent[u] = p
        depth[u] = d
        for _, v := range adj[u] {
            if v != p {
                dfs(v, u, d+1)
            }
        }
    }
    dfs(0, -1, 0)

    path := []int{}
    for u := bob; u != -1; u = parent[u] {
        path = append(path, u)
    }
    m := len(path)
    for i := 0; i < m/2; i++ {
        amount[path[i]] = 0
    }
    if m%2 == 1 {
        amount[path[m/2]] /= 2
    }

    maxProfit := -1 << 31
    var dfs2 func(u, p, profit int)
    dfs2 = func(u, p, profit int) {
        profit += amount[u]
        isLeaf := true
        for _, v := range adj[u] {
            if v != p {
                isLeaf = false
                dfs2(v, u, profit)
            }
        }
        if isLeaf && profit > maxProfit {
            maxProfit = profit
        }
    }
    dfs2(0, -1, 0)
    return maxProfit
}