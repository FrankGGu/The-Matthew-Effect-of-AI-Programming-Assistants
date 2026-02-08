package main

func areConnected(n int, queries []int, threshold int) []bool {
    parent := make([]int, n+1)
    for i := 0; i <= n; i++ {
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
        fx := find(x)
        fy := find(y)
        if fx != fy {
            parent[fx] = fy
        }
    }

    for i := threshold + 1; i <= n; i++ {
        for j := i; j <= n; j += i {
            union(i, j)
        }
    }

    result := make([]bool, len(queries))
    for i := 0; i < len(queries); i++ {
        u, v := queries[i], queries[i+1]
        result[i] = find(u) == find(v)
        i++
    }

    return result
}