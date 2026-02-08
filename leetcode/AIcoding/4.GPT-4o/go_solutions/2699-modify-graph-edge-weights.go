package main

import "sort"

func maxWeightGraph(n int, edges [][]int) []int {
    parent := make([]int, n)
    for i := range parent {
        parent[i] = i
    }

    var find func(int) int
    find = func(x int) int {
        if parent[x] != x {
            parent[x] = find(parent[x])
        }
        return parent[x]
    }

    for i := range edges {
        edges[i][0]-- // Convert to 0-based index
        edges[i][1]-- // Convert to 0-based index
    }

    sort.Slice(edges, func(i, j int) bool {
        return edges[i][2] > edges[j][2]
    })

    result := make([]int, len(edges))
    for i, edge := range edges {
        u, v, w := edge[0], edge[1], edge[2]
        pu := find(u)
        pv := find(v)
        if pu != pv {
            parent[pu] = pv
            result[i] = w
        } else {
            result[i] = 0
        }
    }

    return result
}