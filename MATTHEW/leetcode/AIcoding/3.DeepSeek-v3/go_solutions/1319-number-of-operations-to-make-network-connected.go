func makeConnected(n int, connections [][]int) int {
    if len(connections) < n-1 {
        return -1
    }

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

    union := func(u, v int) {
        uRoot := find(u)
        vRoot := find(v)
        if uRoot != vRoot {
            parent[vRoot] = uRoot
        }
    }

    for _, conn := range connections {
        union(conn[0], conn[1])
    }

    components := 0
    for i := 0; i < n; i++ {
        if find(i) == i {
            components++
        }
    }

    return components - 1
}