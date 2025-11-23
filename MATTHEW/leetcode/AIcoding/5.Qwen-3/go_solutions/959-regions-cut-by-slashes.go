package main

func regionsBySlashes(grid []string) int {
    n := len(grid)
    parent := make([]int, n*n*4)

    for i := 0; i < n*n*4; i++ {
        parent[i] = i
    }

    var find func(x int) int
    find = func(x int) int {
        if parent[x] != x {
            parent[x] = find(parent[x])
        }
        return parent[x]
    }

    union := func(x, y int) {
        px := find(x)
        py := find(y)
        if px != py {
            parent[px] = py
        }
    }

    for i := 0; i < n; i++ {
        for j := 0; j < n; j++ {
            idx := (i*n + j) * 4
            switch grid[i][j] {
            case '/':
                union(idx+0, idx+1)
                union(idx+2, idx+3)
            case '\\':
                union(idx+0, idx+2)
                union(idx+1, idx+3)
            case ' ':
                union(idx+0, idx+1)
                union(idx+1, idx+2)
                union(idx+2, idx+3)
            }
            if i > 0 {
                upIdx := ((i-1)*n + j) * 4
                union(idx+0, upIdx+3)
            }
            if j > 0 {
                leftIdx := (i*n + (j-1)) * 4
                union(idx+1, leftIdx+2)
            }
        }
    }

    roots := make(map[int]bool)
    for i := 0; i < n*n*4; i++ {
        roots[find(i)] = true
    }

    return len(roots)
}