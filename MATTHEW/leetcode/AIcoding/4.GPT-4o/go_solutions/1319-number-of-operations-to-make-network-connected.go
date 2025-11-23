func makeConnected(n int, connections [][]int) int {
    if len(connections) < n-1 {
        return -1
    }

    parent := make([]int, n)
    for i := range parent {
        parent[i] = i
    }

    var find func(int) int
    find = func(x int) int {
        if parent[x] != x {
            parent[x] = find(parent[x])
        }
        return parent[x]
    }

    var union func(int, int)
    union = func(x, y int) {
        rootX := find(x)
        rootY := find(y)
        if rootX != rootY {
            parent[rootY] = rootX
        }
    }

    for _, conn := range connections {
        union(conn[0], conn[1])
    }

    components := 0
    for i := 0; i < n; i++ {
        if parent[i] == i {
            components++
        }
    }

    return components - 1
}