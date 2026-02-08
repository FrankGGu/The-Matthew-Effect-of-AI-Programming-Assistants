func regionsBySlashes(grid []string) int {
    n := len(grid)
    parent := make([]int, 4*n*n)
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

    union := func(x, y int) {
        parent[find(x)] = find(y)
    }

    for i := 0; i < n; i++ {
        for j := 0; j < n; j++ {
            idx := 4 * (i*n + j)
            switch grid[i][j] {
            case '/':
                union(idx, idx+3)
                union(idx+1, idx+2)
            case '\\':
                union(idx, idx+1)
                union(idx+2, idx+3)
            case ' ':
                union(idx, idx+1)
                union(idx+1, idx+2)
                union(idx+2, idx+3)
            }

            if i < n-1 {
                union(idx+2, idx+4*n)
            }
            if j < n-1 {
                union(idx+1, idx+4+3)
            }
        }
    }

    res := 0
    for i := range parent {
        if find(i) == i {
            res++
        }
    }
    return res
}