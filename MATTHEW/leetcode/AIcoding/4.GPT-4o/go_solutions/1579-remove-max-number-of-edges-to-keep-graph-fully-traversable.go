func maxNumEdgesToRemove(n int, edges [][]int) int {
    parent := make([]int, n+1)
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

    var union func(int, int) bool
    union = func(x, y int) bool {
        rootX := find(x)
        rootY := find(y)
        if rootX == rootY {
            return false
        }
        parent[rootX] = rootY
        return true
    }

    totalEdges := 0
    usedEdges := 0

    for _, edge := range edges {
        if edge[0] == 3 {
            if union(edge[1], edge[2]) {
                usedEdges++
            }
            totalEdges++
        }
    }

    for _, edge := range edges {
        if edge[0] == 1 {
            if union(edge[1], edge[2]) {
                usedEdges++
            }
            totalEdges++
        }
    }

    for _, edge := range edges {
        if edge[0] == 2 {
            if union(edge[1], edge[2]) {
                usedEdges++
            }
            totalEdges++
        }
    }

    if usedEdges < n-1 {
        return -1
    }
    return len(edges) - usedEdges
}