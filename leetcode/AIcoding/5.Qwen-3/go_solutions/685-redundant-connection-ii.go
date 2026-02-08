package main

func findRedundantConnectionII(edges [][]int) []int {
    parent := make([]int, 201)

    for i := range parent {
        parent[i] = i
    }

    var find func(x int) int
    find = func(x int) int {
        if parent[x] != x {
            parent[x] = find(parent[x])
        }
        return parent[x]
    }

    for _, edge := range edges {
        x, y := edge[0], edge[1]
        rootX := find(x)
        rootY := find(y)
        if rootX == rootY {
            return edge
        }
        parent[rootY] = rootX
    }

    return nil
}