func maxKDivisibleComponents(n int, edges [][]int, values []int, k int) int {
    adj := make([][]int, n)
    for _, e := range edges {
        u, v := e[0], e[1]
        adj[u] = append(adj[u], v)
        adj[v] = append(adj[v], u)
    }

    res := 0
    var dfs func(int, int) int
    dfs = func(u, parent int) int {
        sum := values[u]
        for _, v := range adj[u] {
            if v != parent {
                sum += dfs(v, u)
            }
        }
        if sum % k == 0 {
            res++
            return 0
        }
        return sum
    }
    dfs(0, -1)
    return res
}