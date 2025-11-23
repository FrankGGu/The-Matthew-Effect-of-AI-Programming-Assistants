func minimumCost(n int, edges [][]int, query [][]int) []int {
    parent := make([]int, n)
    rank := make([]int, n)
    cost := make([]int, n)
    for i := 0; i < n; i++ {
        parent[i] = i
        rank[i] = 1
        cost[i] = -1
    }

    var find func(int) int
    find = func(u int) int {
        if parent[u] != u {
            parent[u] = find(parent[u])
        }
        return parent[u]
    }

    union := func(u, v, w int) {
        rootU := find(u)
        rootV := find(v)
        if rootU != rootV {
            if rank[rootU] > rank[rootV] {
                parent[rootV] = rootU
                cost[rootU] &= cost[rootV]
                cost[rootU] &= w
            } else if rank[rootU] < rank[rootV] {
                parent[rootU] = rootV
                cost[rootV] &= cost[rootU]
                cost[rootV] &= w
            } else {
                parent[rootV] = rootU
                cost[rootU] &= cost[rootV]
                cost[rootU] &= w
                rank[rootU]++
            }
        } else {
            cost[rootU] &= w
        }
    }

    for _, edge := range edges {
        u, v, w := edge[0], edge[1], edge[2]
        union(u, v, w)
    }

    res := make([]int, len(query))
    for i, q := range query {
        u, v := q[0], q[1]
        if u == v {
            res[i] = 0
            continue
        }
        rootU := find(u)
        rootV := find(v)
        if rootU != rootV {
            res[i] = -1
        } else {
            res[i] = cost[rootU]
        }
    }
    return res
}