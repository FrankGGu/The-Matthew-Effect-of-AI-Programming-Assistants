package main

func shortestDistanceAfterRoadAdditions(n int, queries []int) []int {
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

    var union func(x, y int)
    union = func(x, y int) {
        px, py := find(x), find(y)
        if px != py {
            parent[px] = py
        }
    }

    result := make([]int, len(queries))
    for i, q := range queries {
        union(q, q+1)
        result[i] = find(n-1)
    }

    return result
}