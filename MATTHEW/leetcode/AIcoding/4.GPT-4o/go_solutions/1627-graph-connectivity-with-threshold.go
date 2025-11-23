func areConnected(n int, edgeList [][]int, threshold int) []bool {
    parent := make([]int, n+1)
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
        px, py := find(x), find(y)
        if px != py {
            parent[px] = py
        }
    }

    for _, edge := range edgeList {
        if edge[2] > threshold {
            union(edge[0], edge[1])
        }
    }

    result := make([]bool, len(edgeList))
    for i, edge := range edgeList {
        result[i] = find(edge[0]) == find(edge[1])
    }

    return result
}