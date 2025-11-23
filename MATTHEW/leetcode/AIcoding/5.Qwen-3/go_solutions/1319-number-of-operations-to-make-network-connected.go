package main

func makeConnected(n int, connections []int) int {
    if len(connections) < n-1 {
        return -1
    }

    parent := make([]int, n)

    for i := 0; i < n; i++ {
        parent[i] = i
    }

    var find func(x int) int
    find = func(x int) int {
        if parent[x] != x {
            parent[x] = find(parent[x])
        }
        return parent[x]
    }

    for _, conn := range connections {
        x, y := conn/2, conn%2
        px := find(x)
        py := find(y)
        if px != py {
            parent[px] = py
        }
    }

    count := 0
    for i := 0; i < n; i++ {
        if find(i) == i {
            count++
        }
    }

    return count - 1
}