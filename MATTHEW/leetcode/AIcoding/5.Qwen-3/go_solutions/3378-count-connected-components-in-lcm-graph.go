package main

func countComponents(n int, edges [][]int) int {
    parent := make([]int, n)

    for i := 0; i < n; i++ {
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
        rootX := find(x)
        rootY := find(y)
        if rootX != rootY {
            parent[rootY] = rootX
        }
    }

    for _, edge := range edges {
        u, v := edge[0], edge[1]
        union(u, v)
    }

    roots := make(map[int]bool)
    for i := 0; i < n; i++ {
        roots[find(i)] = true
    }

    return len(roots)
}