package main

import "fmt"

func countComponents(n int, edges [][]int) int {
    parent := make([]int, n)
    for i := 0; i < n; i++ {
        parent[i] = i
    }

    var find func(int) int
    find = func(x int) int {
        if parent[x] != x {
            parent[x] = find(parent[x])
        }
        return parent[x]
    }

    var union func(int, int)
    union = func(x, y int) {
        rootX := find(x)
        rootY := find(y)
        if rootX != rootY {
            parent[rootX] = rootY
        }
    }

    for _, edge := range edges {
        union(edge[0], edge[1])
    }

    components := 0
    for i := 0; i < n; i++ {
        if parent[i] == i {
            components++
        }
    }

    return components
}

func main() {
    n := 5
    edges := [][]int{{0, 1}, {1, 2}, {3, 4}}
    fmt.Println(countComponents(n, edges))
}