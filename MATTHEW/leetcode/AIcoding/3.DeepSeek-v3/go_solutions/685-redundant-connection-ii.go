func findRedundantDirectedConnection(edges [][]int) []int {
    n := len(edges)
    parent := make([]int, n+1)
    var first, second, cycle []int

    for _, edge := range edges {
        u, v := edge[0], edge[1]
        if parent[v] != 0 {
            first = []int{parent[v], v}
            second = edge
        } else {
            parent[v] = u
        }
    }

    parent = make([]int, n+1)
    for _, edge := range edges {
        u, v := edge[0], edge[1]
        if edge == second {
            continue
        }
        if find(parent, u) == find(parent, v) {
            if first == nil {
                return edge
            } else {
                return first
            }
        }
        union(parent, u, v)
    }
    return second
}

func find(parent []int, x int) int {
    if parent[x] == 0 {
        return x
    }
    parent[x] = find(parent, parent[x])
    return parent[x]
}

func union(parent []int, x, y int) {
    fx := find(parent, x)
    fy := find(parent, y)
    if fx != fy {
        parent[fy] = fx
    }
}