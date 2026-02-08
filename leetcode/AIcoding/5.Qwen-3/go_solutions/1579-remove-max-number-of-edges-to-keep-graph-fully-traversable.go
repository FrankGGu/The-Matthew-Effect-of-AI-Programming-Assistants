package main

func removeMaxEdgesToRemoveGraphFullyTraversable(n int, edges [][]int) int {
    parent1 := make([]int, n+1)
    parent2 := make([]int, n+1)
    for i := 0; i <= n; i++ {
        parent1[i] = i
        parent2[i] = i
    }

    var find func(p []int, x int) int
    find = func(p []int, x int) int {
        if p[x] != x {
            p[x] = find(p, p[x])
        }
        return p[x]
    }

    var union func(p []int, x, y int) bool
    union = func(p []int, x, y int) bool {
        px := find(p, x)
        py := find(p, y)
        if px == py {
            return false
        }
        p[px] = py
        return true
    }

    count := 0

    for _, e := range edges {
        u, v := e[1], e[2]
        if e[0] == 1 {
            if !union(parent1, u, v) {
                count++
            }
        } else if e[0] == 2 {
            if !union(parent2, u, v) {
                count++
            }
        }
    }

    for _, e := range edges {
        u, v := e[1], e[2]
        if e[0] == 1 {
            if !union(parent2, u, v) {
                count++
            }
        } else if e[0] == 2 {
            if !union(parent1, u, v) {
                count++
            }
        }
    }

    root1 := find(parent1, 1)
    for i := 2; i <= n; i++ {
        if find(parent1, i) != root1 {
            return -1
        }
    }

    root2 := find(parent2, 1)
    for i := 2; i <= n; i++ {
        if find(parent2, i) != root2 {
            return -1
        }
    }

    return count
}