package main

func countCompleteComponents(n int, edges [][]int) int {
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

    union := func(x, y int) {
        px, py := find(x), find(y)
        if px != py {
            parent[px] = py
        }
    }

    for _, e := range edges {
        union(e[0], e[1])
    }

    groups := make(map[int][]int)
    for i := 0; i < n; i++ {
        root := find(i)
        groups[root] = append(groups[root], i)
    }

    result := 0
    for _, nodes := range groups {
        m := len(nodes)
        if m == 1 {
            continue
        }
        valid := true
        for i := 0; i < m && valid; i++ {
            for j := 0; j < m && valid; j++ {
                if nodes[i] == nodes[j] {
                    continue
                }
                if !contains(edges, []int{nodes[i], nodes[j]}) && !contains(edges, []int{nodes[j], nodes[i]}) {
                    valid = false
                }
            }
        }
        if valid {
            result++
        }
    }

    return result
}

func contains(slice [][]int, target []int) bool {
    for _, s := range slice {
        if s[0] == target[0] && s[1] == target[1] {
            return true
        }
    }
    return false
}