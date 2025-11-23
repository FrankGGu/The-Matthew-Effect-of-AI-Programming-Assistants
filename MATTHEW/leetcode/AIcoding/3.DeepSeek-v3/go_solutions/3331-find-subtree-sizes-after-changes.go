func subtreeSizeAfterChanges(n int, edges [][]int, changes [][]int) []int {
    adj := make([][]int, n)
    for _, e := range edges {
        u, v := e[0], e[1]
        adj[u] = append(adj[u], v)
        adj[v] = append(adj[v], u)
    }

    parent := make([]int, n)
    size := make([]int, n)
    var dfs func(u, p int)
    dfs = func(u, p int) {
        parent[u] = p
        size[u] = 1
        for _, v := range adj[u] {
            if v != p {
                dfs(v, u)
                size[u] += size[v]
            }
        }
    }
    dfs(0, -1)

    res := make([]int, len(changes))
    for i, change := range changes {
        u, v := change[0], change[1]
        if parent[u] == v {
            u, v = v, u
        }
        if parent[v] != u {
            continue
        }
        parent[v] = -1
        size[u] -= size[v]
        res[i] = size[0]
    }
    return res
}