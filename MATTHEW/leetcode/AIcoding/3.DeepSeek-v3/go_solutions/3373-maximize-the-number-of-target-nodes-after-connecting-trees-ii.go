func maximumTargetNodesAfterConnections(n int, edges [][]int, target []int) int {
    parent := make([]int, n+1)
    size := make([]int, n+1)
    for i := 1; i <= n; i++ {
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

    union := func(u, v int) {
        pu, pv := find(u), find(v)
        if pu == pv {
            return
        }
        if size[pu] < size[pv] {
            pu, pv = pv, pu
        }
        parent[pv] = pu
        size[pu] += size[pv]
    }

    for _, edge := range edges {
        u, v := edge[0], edge[1]
        union(u, v)
    }

    targetSet := make(map[int]bool)
    for _, t := range target {
        targetSet[t] = true
    }

    count := 0
    for i := 1; i <= n; i++ {
        if parent[i] == i && targetSet[i] {
            count += size[i]
        }
    }

    return count
}