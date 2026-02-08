func rootCount(edges [][]int, guesses [][]int, k int) int {
    n := len(edges) + 1
    adj := make([][]int, n)
    for _, e := range edges {
        u, v := e[0], e[1]
        adj[u] = append(adj[u], v)
        adj[v] = append(adj[v], u)
    }

    guessSet := make(map[[2]int]struct{})
    for _, g := range guesses {
        u, v := g[0], g[1]
        guessSet[[2]int{u, v}] = struct{}{}
    }

    parent := make([]int, n)
    for i := range parent {
        parent[i] = -1
    }
    var buildParent func(u int)
    buildParent = func(u int) {
        for _, v := range adj[u] {
            if v != parent[u] {
                parent[v] = u
                buildParent(v)
            }
        }
    }
    buildParent(0)

    correct := 0
    for v := 1; v < n; v++ {
        u := parent[v]
        if _, ok := guessSet[[2]int{u, v}]; ok {
            correct++
        }
    }

    res := 0
    var dfs func(u, p, cnt int)
    dfs = func(u, p, cnt int) {
        if cnt >= k {
            res++
        }
        for _, v := range adj[u] {
            if v == p {
                continue
            }
            newCnt := cnt
            if _, ok := guessSet[[2]int{u, v}]; ok {
                newCnt--
            }
            if _, ok := guessSet[[2]int{v, u}]; ok {
                newCnt++
            }
            dfs(v, u, newCnt)
        }
    }
    dfs(0, -1, correct)

    return res
}