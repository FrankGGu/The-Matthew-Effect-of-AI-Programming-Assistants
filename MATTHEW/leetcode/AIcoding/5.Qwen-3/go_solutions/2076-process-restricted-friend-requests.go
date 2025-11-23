package main

func friendRequests(n int, restrictions [][]int) int {
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

    var union func(x, y int) bool
    union = func(x, y int) bool {
        rootX := find(x)
        rootY := find(y)
        if rootX == rootY {
            return false
        }
        parent[rootY] = rootX
        return true
    }

    for _, r := range restrictions {
        a, b := r[0], r[1]
        ra, rb := find(a), find(b)
        if ra == rb {
            continue
        }
        union(a, b)
    }

    result := 0
    for i := 0; i < n; i++ {
        for j := i + 1; j < n; j++ {
            if find(i) == find(j) {
                result++
            }
        }
    }

    return result
}