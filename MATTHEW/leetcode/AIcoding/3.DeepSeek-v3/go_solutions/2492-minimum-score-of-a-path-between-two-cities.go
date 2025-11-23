func minScore(n int, roads [][]int) int {
    parent := make([]int, n+1)
    minScore := make([]int, n+1)
    for i := 1; i <= n; i++ {
        parent[i] = i
        minScore[i] = math.MaxInt32
    }

    var find func(int) int
    find = func(u int) int {
        if parent[u] != u {
            parent[u] = find(parent[u])
        }
        return parent[u]
    }

    union := func(u, v, score int) {
        rootU := find(u)
        rootV := find(v)
        if rootU != rootV {
            parent[rootV] = rootU
            if minScore[rootU] > minScore[rootV] {
                minScore[rootU] = minScore[rootV]
            }
        }
        if minScore[rootU] > score {
            minScore[rootU] = score
        }
    }

    for _, road := range roads {
        u, v, score := road[0], road[1], road[2]
        union(u, v, score)
    }

    root1 := find(1)
    rootN := find(n)
    if root1 != rootN {
        return -1
    }
    return minScore[root1]
}