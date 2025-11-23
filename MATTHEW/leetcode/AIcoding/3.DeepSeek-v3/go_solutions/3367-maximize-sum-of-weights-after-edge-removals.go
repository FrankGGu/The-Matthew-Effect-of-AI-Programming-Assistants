func maximumWeight(n int, edges [][]int, signalSpeed int) int {
    adj := make([][]pair, n)
    for _, e := range edges {
        u, v, w := e[0], e[1], e[2]
        adj[u] = append(adj[u], pair{v, w})
        adj[v] = append(adj[v], pair{u, w})
    }

    res := 0
    var dfs func(u, parent, sum int) int
    dfs = func(u, parent, sum int) int {
        cnt := 0
        if sum%signalSpeed == 0 {
            cnt++
        }
        for _, p := range adj[u] {
            v, w := p.v, p.w
            if v != parent {
                cnt += dfs(v, u, sum+w)
            }
        }
        return cnt
    }

    for i := 0; i < n; i++ {
        for _, p := range adj[i] {
            j, w := p.v, p.w
            if i < j {
                cnt1 := dfs(i, j, 0)
                cnt2 := dfs(j, i, 0)
                res += cnt1 * cnt2 * w
            }
        }
    }
    return res
}

type pair struct {
    v, w int
}