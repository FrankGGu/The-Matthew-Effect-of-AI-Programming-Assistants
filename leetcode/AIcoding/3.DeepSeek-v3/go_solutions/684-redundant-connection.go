func findRedundantConnection(edges [][]int) []int {
    parent := make([]int, len(edges)+1)
    for i := range parent {
        parent[i] = i
    }

    var find func(int) int
    find = func(u int) int {
        if parent[u] != u {
            parent[u] = find(parent[u])
        }
        return parent[u]
    }

    for _, edge := range edges {
        u, v := edge[0], edge[1]
        pu, pv := find(u), find(v)
        if pu == pv {
            return edge
        }
        parent[pv] = pu
    }
    return nil
}