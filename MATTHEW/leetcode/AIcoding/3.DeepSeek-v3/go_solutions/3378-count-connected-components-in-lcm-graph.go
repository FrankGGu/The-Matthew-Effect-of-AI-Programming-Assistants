func countComponentsLCM(n int, edges [][]int) int {
    parent := make([]int, n+1)
    for i := 1; i <= n; i++ {
        parent[i] = i
    }

    var find func(int) int
    find = func(u int) int {
        if parent[u] != u {
            parent[u] = find(parent[u])
        }
        return parent[u]
    }

    union := func(u, v int) {
        pu, pv := find(u), find(v)
        if pu != pv {
            parent[pu] = pv
        }
    }

    for _, edge := range edges {
        u, v := edge[0], edge[1]
        union(u, v)
    }

    components := make(map[int]bool)
    for i := 1; i <= n; i++ {
        components[find(i)] = true
    }

    return len(components)
}