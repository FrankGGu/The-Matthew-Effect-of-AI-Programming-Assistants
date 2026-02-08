func removeStones(stones [][]int) int {
    n := len(stones)
    parent := make([]int, n)
    for i := 0; i < n; i++ {
        parent[i] = i
    }

    var find func(int) int
    find = func(i int) int {
        if parent[i] == i {
            return i
        }
        parent[i] = find(parent[i])
        return parent[i]
    }

    union := func(i, j int) {
        rootI := find(i)
        rootJ := find(j)
        if rootI != rootJ {
            parent[rootI] = rootJ
        }
    }

    for i := 0; i < n; i++ {
        for j := i + 1; j < n; j++ {
            if stones[i][0] == stones[j][0] || stones[i][1] == stones[j][1] {
                union(i, j)
            }
        }
    }

    count := 0
    for i := 0; i < n; i++ {
        if parent[i] == i {
            count++
        }
    }

    return n - count
}