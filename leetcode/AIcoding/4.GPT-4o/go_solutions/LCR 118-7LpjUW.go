func findRedundantDirectedConnection(edges [][]int) []int {
    parent := make([]int, len(edges)+1)
    rank := make([]int, len(edges)+1)
    var firstEdge, secondEdge []int
    for _, edge := range edges {
        u, v := edge[0], edge[1]
        if parent[v] != 0 {
            firstEdge = []int{parent[v], v}
            secondEdge = edge
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
            if firstEdge == nil {
                return edge
            }
            return firstEdge
        }
        union(parent, u, v)
    }
    return secondEdge
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