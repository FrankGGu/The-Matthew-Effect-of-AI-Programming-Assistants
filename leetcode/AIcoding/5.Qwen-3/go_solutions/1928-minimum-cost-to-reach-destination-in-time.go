package main

func minCostConnectPoints(points [][]int) int {
    n := len(points)
    edges := make([][]int, 0)
    for i := 0; i < n; i++ {
        for j := i + 1; j < n; j++ {
            cost := abs(points[i][0]-points[j][0]) + abs(points[i][1]-points[j][1])
            edges = append(edges, []int{i, j, cost})
        }
    }

    sort.Slice(edges, func(i, j int) bool {
        return edges[i][2] < edges[j][2]
    })

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

    result := 0
    count := 0
    for _, edge := range edges {
        x, y, cost := edge[0], edge[1], edge[2]
        rootX := find(x)
        rootY := find(y)
        if rootX != rootY {
            parent[rootX] = rootY
            result += cost
            count++
            if count == n-1 {
                break
            }
        }
    }

    return result
}

func abs(x int) int {
    if x < 0 {
        return -x
    }
    return x
}