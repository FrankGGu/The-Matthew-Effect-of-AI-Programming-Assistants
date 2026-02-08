func findRedundantDirectedConnection(edges [][]int) []int {
    parent := make([]int, len(edges)+1)
    for i := range parent {
        parent[i] = i
    }

    var edgeToRemove []int
    for _, edge := range edges {
        u, v := edge[0], edge[1]
        if parent[v] != v {
            edgeToRemove = edge
            continue
        }
        parent[v] = u
    }

    uf := func(n int) int {
        root := make([]int, n+1)
        for i := 1; i <= n; i++ {
            root[i] = i
        }
        var find func(int) int
        find = func(x int) int {
            if root[x] != x {
                root[x] = find(root[x])
            }
            return root[x]
        }
        var union func(int, int) bool
        union = func(x, y int) bool {
            rootX := find(x)
            rootY := find(y)
            if rootX == rootY {
                return false
            }
            root[rootX] = rootY
            return true
        }

        for _, edge := range edges {
            if edgeToRemove != nil && (edge[0] == edgeToRemove[0] && edge[1] == edgeToRemove[1]) {
                continue
            }
            if !union(edge[0], edge[1]) {
                return edge[0]
            }
        }
        return 0
    }

    if edgeToRemove == nil {
        return nil
    }

    if uf(len(edges)) == 0 {
        return edgeToRemove
    }

    return []int{parent[edgeToRemove[1]], edgeToRemove[1]}
}