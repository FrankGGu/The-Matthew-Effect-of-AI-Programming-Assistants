func countWays(n int, edges [][]int) int {
    mod := int(1e9 + 7)
    adj := make([][]int, n)
    for _, e := range edges {
        u, v := e[0], e[1]
        adj[u] = append(adj[u], v)
        adj[v] = append(adj[v], u)
    }

    parent := make([]int, n)
    size := make([]int, n)
    var dfs func(int, int)
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

    fact := make([]int, n)
    invFact := make([]int, n)
    fact[0] = 1
    for i := 1; i < n; i++ {
        fact[i] = fact[i-1] * i % mod
    }
    invFact[n-1] = pow(fact[n-1], mod-2, mod)
    for i := n - 2; i >= 0; i-- {
        invFact[i] = invFact[i+1] * (i + 1) % mod
    }

    res := 1
    for u := 0; u < n; u++ {
        if len(adj[u]) <= 1 {
            continue
        }
        children := make([]int, 0)
        for _, v := range adj[u] {
            if v != parent[u] {
                children = append(children, size[v])
            }
        }
        if parent[u] != -1 {
            children = append(children, n-size[u])
        }
        ways := fact[len(children)]
        for _, s := range children {
            ways = ways * invFact[s] % mod
        }
        res = res * ways % mod
    }
    return res
}

func pow(a, b, mod int) int {
    res := 1
    for b > 0 {
        if b&1 == 1 {
            res = res * a % mod
        }
        a = a * a % mod
        b >>= 1
    }
    return res
}