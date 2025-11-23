package main

func waysToAssignEdgeWeightsII(n int, edges [][]int) int {
    parent := make([]int, n)
    rank := make([]int, n)

    for i := 0; i < n; i++ {
        parent[i] = i
        rank[i] = 1
    }

    find := func(x int) int {
        if parent[x] != x {
            parent[x] = find(parent[x])
        }
        return parent[x]
    }

    union := func(x, y int) bool {
        fx := find(x)
        fy := find(y)
        if fx == fy {
            return false
        }
        if rank[fx] < rank[fy] {
            parent[fx] = fy
        } else {
            parent[fy] = fx
            if rank[fx] == rank[fy] {
                rank[fx]++
            }
        }
        return true
    }

    for _, edge := range edges {
        u, v := edge[0], edge[1]
        union(u, v)
    }

    roots := make(map[int]bool)
    for i := 0; i < n; i++ {
        roots[find(i)] = true
    }

    m := len(edges)
    if m == 0 {
        return 1
    }

    count := make(map[int]int)
    for _, edge := range edges {
        u, v := edge[0], edge[1]
        root := find(u)
        count[root]++
    }

    res := 1
    for _, c := range count {
        res *= pow(2, c-1)
    }

    return res
}

func pow(a, b int) int {
    result := 1
    for b > 0 {
        if b%2 == 1 {
            result *= a
        }
        a *= a
        b /= 2
    }
    return result
}