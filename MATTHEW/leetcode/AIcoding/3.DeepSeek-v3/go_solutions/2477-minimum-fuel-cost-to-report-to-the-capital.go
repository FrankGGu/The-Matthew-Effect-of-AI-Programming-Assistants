func minimumFuelCost(roads [][]int, seats int) int64 {
    n := len(roads) + 1
    adj := make([][]int, n)
    for _, road := range roads {
        u, v := road[0], road[1]
        adj[u] = append(adj[u], v)
        adj[v] = append(adj[v], u)
    }

    var res int64
    var dfs func(int, int) int
    dfs = func(u, parent int) int {
        people := 1
        for _, v := range adj[u] {
            if v != parent {
                p := dfs(v, u)
                people += p
                res += int64((p + seats - 1) / seats)
            }
        }
        return people
    }
    dfs(0, -1)
    return res
}