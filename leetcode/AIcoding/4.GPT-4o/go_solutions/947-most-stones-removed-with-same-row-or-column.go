package main

import "fmt"

func removeStones(stones [][]int) int {
    parent := make([]int, len(stones))
    for i := range parent {
        parent[i] = i
    }

    find := func(x int) int {
        if parent[x] != x {
            parent[x] = find(parent[x])
        }
        return parent[x]
    }

    union := func(x, y int) {
        rootX := find(x)
        rootY := find(y)
        if rootX != rootY {
            parent[rootX] = rootY
        }
    }

    rowMap := make(map[int][]int)
    colMap := make(map[int][]int)

    for i, stone := range stones {
        rowMap[stone[0]] = append(rowMap[stone[0]], i)
        colMap[stone[1]] = append(colMap[stone[1]], i)
    }

    for _, indices := range rowMap {
        for i := 1; i < len(indices); i++ {
            union(indices[0], indices[i])
        }
    }

    for _, indices := range colMap {
        for i := 1; i < len(indices); i++ {
            union(indices[0], indices[i])
        }
    }

    rootSet := make(map[int]struct{})
    for i := 0; i < len(stones); i++ {
        rootSet[find(i)] = struct{}{}
    }

    return len(stones) - len(rootSet)
}

func main() {
    stones := [][]int{{0, 0}, {0, 1}, {1, 0}, {1, 1}, {2, 2}}
    fmt.Println(removeStones(stones)) // Output: 3
}