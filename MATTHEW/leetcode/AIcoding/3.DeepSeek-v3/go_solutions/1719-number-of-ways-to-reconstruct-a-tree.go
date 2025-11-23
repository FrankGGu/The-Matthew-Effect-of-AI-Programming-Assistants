func checkWays(pairs [][]int) int {
    adj := make(map[int]map[int]bool)
    for _, pair := range pairs {
        u, v := pair[0], pair[1]
        if adj[u] == nil {
            adj[u] = make(map[int]bool)
        }
        if adj[v] == nil {
            adj[v] = make(map[int]bool)
        }
        adj[u][v] = true
        adj[v][u] = true
    }

    nodes := make([]int, 0, len(adj))
    for u := range adj {
        nodes = append(nodes, u)
    }
    sort.Slice(nodes, func(i, j int) bool {
        return len(adj[nodes[i]]) > len(adj[nodes[j]])
    })

    n := len(nodes)
    if len(adj[nodes[0]]) != n-1 {
        return 0
    }

    res := 1
    parent := make(map[int]int)
    for i := 1; i < n; i++ {
        u := nodes[i]
        found := false
        for j := i - 1; j >= 0; j-- {
            v := nodes[j]
            if adj[u][v] {
                parent[u] = v
                found = true
                break
            }
        }
        if !found {
            return 0
        }
    }

    for i := 1; i < n; i++ {
        u := nodes[i]
        v := parent[u]
        for w := range adj[u] {
            if w != v && !adj[v][w] {
                return 0
            }
        }
        if len(adj[u]) == len(adj[v]) {
            res = 2
        }
    }
    return res
}