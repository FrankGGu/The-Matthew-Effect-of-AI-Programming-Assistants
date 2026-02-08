const mod = 1e9 + 7

func waysToBuildRooms(prevRoom []int) int {
    n := len(prevRoom)
    graph := make([][]int, n)
    for i := 1; i < n; i++ {
        p := prevRoom[i]
        graph[p] = append(graph[p], i)
    }

    fact := make([]int, n+1)
    invFact := make([]int, n+1)
    fact[0] = 1
    for i := 1; i <= n; i++ {
        fact[i] = fact[i-1] * i % mod
    }
    invFact[n] = pow(fact[n], mod-2)
    for i := n - 1; i >= 0; i-- {
        invFact[i] = invFact[i+1] * (i + 1) % mod
    }

    size := make([]int, n)
    res := 1
    var dfs func(int)
    dfs = func(u int) {
        size[u] = 1
        for _, v := range graph[u] {
            dfs(v)
            size[u] += size[v]
        }
        temp := fact[size[u]-1]
        for _, v := range graph[u] {
            temp = temp * invFact[size[v]] % mod
        }
        res = res * temp % mod
    }
    dfs(0)
    return res
}

func pow(a, b int) int {
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