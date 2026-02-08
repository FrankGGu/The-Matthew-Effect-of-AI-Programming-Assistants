package main

type Edge struct {
    from, to, limit int
}

func distanceLimitedPathsExist(n int, queries [][]int, edges []Edge) []bool {
    sort.Slice(queries, func(i, j int) bool {
        return queries[i][2] < queries[j][2]
    })
    sort.Slice(edges, func(i, j int) bool {
        return edges[i].limit < edges[j].limit
    })

    parent := make([]int, n)
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

    var union func(x, y int)
    union = func(x, y int) {
        fx := find(x)
        fy := find(y)
        if fx != fy {
            parent[fx] = fy
        }
    }

    res := make([]bool, len(queries))
    edgeIdx := 0

    for _, q := range queries {
        u, v, limit := q[0], q[1], q[2]
        for edgeIdx < len(edges) && edges[edgeIdx].limit < limit {
            union(edges[edgeIdx].from, edges[edgeIdx].to)
            edgeIdx++
        }
        if find(u) == find(v) {
            res[q[3]] = true
        }
    }

    return res
}