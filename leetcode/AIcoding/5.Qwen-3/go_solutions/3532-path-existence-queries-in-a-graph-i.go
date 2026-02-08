package main

func isPathExist(n int, edges [][]int, queries []int) []bool {
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
        px, py := find(x), find(y)
        if px != py {
            parent[px] = py
        }
    }

    for _, e := range edges {
        union(e[0], e[1])
    }

    result := make([]bool, len(queries))
    for i, q := range queries {
        root := find(q)
        result[i] = true
        for j := 0; j < n; j++ {
            if find(j) != root {
                result[i] = false
                break
            }
        }
    }

    return result
}