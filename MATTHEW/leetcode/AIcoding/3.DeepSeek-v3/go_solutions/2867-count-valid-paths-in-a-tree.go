func countValidPaths(n int, edges [][]int) int64 {
    isPrime := make([]bool, n+1)
    for i := 2; i <= n; i++ {
        isPrime[i] = true
    }
    for i := 2; i*i <= n; i++ {
        if isPrime[i] {
            for j := i * i; j <= n; j += i {
                isPrime[j] = false
            }
        }
    }
    if n < 2 {
        isPrime[1] = false
    }

    adj := make([][]int, n+1)
    for _, e := range edges {
        u, v := e[0], e[1]
        adj[u] = append(adj[u], v)
        adj[v] = append(adj[v], u)
    }

    var res int64 = 0
    size := make([]int, n+1)

    var dfs func(int, int)
    dfs = func(u, parent int) {
        size[u] = 1
        for _, v := range adj[u] {
            if v == parent {
                continue
            }
            dfs(v, u)
            size[u] += size[v]
        }
    }
    dfs(1, -1)

    var dfs2 func(int, int, int)
    dfs2 = func(u, parent, primeParent int) {
        if isPrime[u] {
            primeParent = u
        }
        if primeParent != -1 {
            if isPrime[u] {
                res += int64(size[u])
            } else {
                cnt := size[u]
                for _, v := range adj[u] {
                    if v == parent {
                        continue
                    }
                    if isPrime[v] {
                        cnt -= size[v]
                    }
                }
                res += int64(cnt)
            }
        }
        for _, v := range adj[u] {
            if v == parent {
                continue
            }
            dfs2(v, u, primeParent)
        }
    }
    dfs2(1, -1, -1)

    return res
}