func maxSumEdgeValues(n int, edges [][]int) int {
    parent := make([]int, n)
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

    sort.Slice(edges, func(i, j int) bool {
        return edges[i][2] > edges[j][2]
    })

    res := 0
    for _, edge := range edges {
        u, v, w := edge[0], edge[1], edge[2]
        pu, pv := find(u), find(v)
        if pu != pv {
            res += w
            parent[pu] = pv
        }
    }

    return res
}