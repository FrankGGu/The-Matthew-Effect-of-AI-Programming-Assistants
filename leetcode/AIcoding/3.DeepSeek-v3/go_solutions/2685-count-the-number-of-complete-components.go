func countCompleteComponents(n int, edges [][]int) int {
    parent := make([]int, n)
    size := make([]int, n)
    edgeCount := make([]int, n)

    for i := 0; i < n; i++ {
        parent[i] = i
        size[i] = 1
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
        rootU := find(u)
        rootV := find(v)
        if rootU != rootV {
            if size[rootU] < size[rootV] {
                rootU, rootV = rootV, rootU
            }
            parent[rootV] = rootU
            size[rootU] += size[rootV]
            edgeCount[rootU] += edgeCount[rootV]
        }
        edgeCount[rootU]++
    }

    visited := make(map[int]bool)
    res := 0
    for i := 0; i < n; i++ {
        root := find(i)
        if !visited[root] {
            visited[root] = true
            nodes := size[root]
            expectedEdges := nodes * (nodes - 1) / 2
            if edgeCount[root] == expectedEdges {
                res++
            }
        }
    }
    return res
}