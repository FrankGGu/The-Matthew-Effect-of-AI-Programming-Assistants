package main

func isSameRoot(x, y int, parent []int) bool {
    var find func(int) int
    find = func(x int) int {
        if parent[x] != x {
            parent[x] = find(parent[x])
        }
        return parent[x]
    }
    return find(x) == find(y)
}

func union(x, y int, parent []int) {
    rootX := find(x, parent)
    rootY := find(y, parent)
    if rootX != rootY {
        parent[rootY] = rootX
    }
}

func find(x int, parent []int) int {
    if parent[x] != x {
        parent[x] = find(parent[x], parent)
    }
    return parent[x]
}

func gcd(a, b int) int {
    for b != 0 {
        a, b = b, a%b
    }
    return a
}

func hasValidPath(grid [][]int) bool {
    m, n := len(grid), len(grid[0])
    size := m * n
    parent := make([]int, size)
    for i := range parent {
        parent[i] = i
    }

    getIdx := func(i, j int) int {
        return i*n + j
    }

    for i := 0; i < m; i++ {
        for j := 0; j < n; j++ {
            num := grid[i][j]
            for ni, nj := 0, 0; ni < m; ni++ {
                for nj < n; nj++ {
                    if ni == i && nj == j {
                        continue
                    }
                    neighborNum := grid[ni][nj]
                    if gcd(num, neighborNum) > 1 {
                        idx := getIdx(i, j)
                        neighborIdx := getIdx(ni, nj)
                        union(idx, neighborIdx, parent)
                    }
                }
            }
        }
    }

    start := getIdx(0, 0)
    end := getIdx(m-1, n-1)
    return isSameRoot(start, end, parent)
}