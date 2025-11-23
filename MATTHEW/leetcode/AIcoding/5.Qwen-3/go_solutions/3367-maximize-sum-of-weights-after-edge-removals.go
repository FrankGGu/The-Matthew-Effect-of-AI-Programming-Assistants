package main

import "sort"

func maxSumOfWeights(n int, edges [][]int, queries []int) []int {
    parent := make([]int, n)
    weight := make([]int, n)
    for i := 0; i < n; i++ {
        parent[i] = i
        weight[i] = 1
    }

    var find func(x int) int
    find = func(x int) int {
        if parent[x] != x {
            parent[x] = find(parent[x])
        }
        return parent[x]
    }

    union := func(x, y int) {
        fx := find(x)
        fy := find(y)
        if fx == fy {
            return
        }
        if weight[fx] < weight[fy] {
            fx, fy = fy, fx
        }
        parent[fy] = fx
        weight[fx] += weight[fy]
    }

    for _, e := range edges {
        union(e[0], e[1])
    }

    nodes := make([]int, n)
    for i := 0; i < n; i++ {
        nodes[i] = weight[find(i)]
    }

    sort.Sort(sort.Reverse(sort.IntSlice(nodes)))

    res := make([]int, len(queries))
    for i, q := range queries {
        sum := 0
        count := 0
        for _, w := range nodes {
            if count < q {
                sum += w
                count++
            } else {
                break
            }
        }
        res[i] = sum
    }

    return res
}