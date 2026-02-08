package main

func minimizeHammingDistance(s string, a []int) int {
    n := len(s)
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

    union := func(x, y int) {
        px, py := find(x), find(y)
        if px != py {
            parent[px] = py
        }
    }

    for _, i := range a {
        union(i, i+1)
    }

    groups := make(map[int][]byte)
    for i := 0; i < n; i++ {
        root := find(i)
        groups[root] = append(groups[root], s[i])
    }

    res := 0
    for _, group := range groups {
        count := make(map[byte]int)
        for _, c := range group {
            count[c]++
        }
        maxFreq := 0
        for _, v := range count {
            if v > maxFreq {
                maxFreq = v
            }
        }
        res += len(group) - maxFreq
    }

    return res
}