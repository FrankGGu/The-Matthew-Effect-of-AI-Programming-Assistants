package main

func shortestDistanceAfterRoadAdditions(n int, queries []int) []int {
    parent := make([]int, n)
    for i := 0; i < n; i++ {
        parent[i] = i
    }

    find := func(x int) int {
        for x != parent[x] {
            parent[x] = parent[parent[x]]
            x = parent[x]
        }
        return x
    }

    union := func(x, y int) {
        fx := find(x)
        fy := find(y)
        if fx != fy {
            parent[fx] = fy
        }
    }

    result := make([]int, len(queries))
    for i, q := range queries {
        union(q, q+1)
        result[i] = find(n-1)
    }

    return result
}