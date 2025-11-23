func countPairs(n int, edges [][]int) int64 {
    parent := make([]int, n)
    size := make([]int, n)
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

    union := func(u, v int) {
        rootU := find(u)
        rootV := find(v)
        if rootU != rootV {
            if size[rootU] < size[rootV] {
                rootU, rootV = rootV, rootU
            }
            parent[rootV] = rootU
            size[rootU] += size[rootV]
        }
    }

    for _, edge := range edges {
        u, v := edge[0], edge[1]
        union(u, v)
    }

    var res int64
    total := int64(n)
    visited := make(map[int]bool)
    for i := 0; i < n; i++ {
        root := find(i)
        if !visited[root] {
            cnt := int64(size[root])
            res += cnt * (total - cnt)
            visited[root] = true
        }
    }

    return res / 2
}