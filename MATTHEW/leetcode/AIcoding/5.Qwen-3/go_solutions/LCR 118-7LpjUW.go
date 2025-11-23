package main

func findRedundantConnection(edges [][]int) []int {
    parent := make([]int, len(edges)+1)

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
        if find(x) == find(y) {
            return edge
        }
        parent[find(x)] = find(y)
    }

    return nil
}