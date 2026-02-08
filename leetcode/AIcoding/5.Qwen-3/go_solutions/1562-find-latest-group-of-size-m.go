package main

func findLatestGroup(arr []int, m int) int {
    n := len(arr)
    parent := make([]int, n+1)
    size := make([]int, n+1)
    for i := range parent {
        parent[i] = i
        size[i] = 1
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
        rootX := find(x)
        rootY := find(y)
        if rootX == rootY {
            return
        }
        if size[rootX] < size[rootY] {
            rootX, rootY = rootY, rootX
        }
        parent[rootY] = rootX
        size[rootX] += size[rootY]
    }

    result := -1
    for i := 0; i < n; i++ {
        pos := arr[i]
        if pos > 1 && size[find(pos-1)] > 0 {
            union(pos, pos-1)
        }
        if pos < n && size[find(pos+1)] > 0 {
            union(pos, pos+1)
        }
        if size[find(pos)] == m {
            result = i + 1
        }
    }
    return result
}