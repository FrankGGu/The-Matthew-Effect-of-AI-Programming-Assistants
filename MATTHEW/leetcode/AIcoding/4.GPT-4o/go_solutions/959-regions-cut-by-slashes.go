func regionsBySlashes(grid []string) int {
    n := len(grid)
    parent := make([]int, (n+1)*(n+1))
    for i := 0; i < len(parent); i++ {
        parent[i] = i
    }

    find := func(x int) int {
        if parent[x] != x {
            parent[x] = find(parent[x])
        }
        return parent[x]
    }

    union := func(x, y int) {
        rootX := find(x)
        rootY := find(y)
        if rootX != rootY {
            parent[rootX] = rootY
        }
    }

    for i := 0; i < n; i++ {
        for j := 0; j < n; j++ {
            if grid[i][j] == ' ' {
                union(i*(n+1)+j, i*(n+1)+j+1)
                union(i*(n+1)+j, (i+1)*(n+1)+j)
            } else if grid[i][j] == '/' {
                union(i*(n+1)+j+1, (i+1)*(n+1)+j)
            } else {
                union(i*(n+1)+j, (i+1)*(n+1)+j+1)
            }
        }
    }

    regions := 0
    for i := 0; i < (n+1)*(n+1); i++ {
        if parent[i] == i {
            regions++
        }
    }

    return regions
}