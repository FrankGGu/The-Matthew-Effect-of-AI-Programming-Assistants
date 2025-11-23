func findRedundantDirectedConnection(edges [][]int) []int {
    parent := make([]int, len(edges)+1)
    for i := range parent {
        parent[i] = i
    }

    var first, second []int
    for _, edge := range edges {
        u, v := edge[0], edge[1]
        if parent[v] != v {
            second = edge
            edge[1] = 0
        } else {
            parent[v] = u
        }
    }

    for i := 1; i < len(parent); i++ {
        parent[i] = i
    }

    for _, edge := range edges {
        if edge[1] == 0 {
            continue
        }
        u, v := edge[0], edge[1]
        if find(parent, u) == find(parent, v) {
            if second == nil {
                return edge
            }
            return second
        }
        union(parent, u, v)
    }

    return nil
}

func find(parent []int, u int) int {
    if parent[u] != u {
        parent[u] = find(parent, parent[u])
    }
    return parent[u]
}

func union(parent []int, u, v int) {
    pu, pv := find(parent, u), find(parent, v)
    if pu != pv {
        parent[pu] = pv
    }
}