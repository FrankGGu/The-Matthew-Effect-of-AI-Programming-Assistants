func minimizeHammingDistance(source []int, target []int, allowedSwaps [][]int) int {
    parent := make([]int, len(source))
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
        px := find(x)
        py := find(y)
        if px != py {
            parent[px] = py
        }
    }

    for _, swap := range allowedSwaps {
        union(swap[0], swap[1])
    }

    groups := make(map[int][]int)
    for i := 0; i < len(source); i++ {
        root := find(i)
        groups[root] = append(groups[root], i)
    }

    total := 0
    for _, indices := range groups {
        countSource := make(map[int]int)
        countTarget := make(map[int]int)
        for _, index := range indices {
            countSource[source[index]]++
            countTarget[target[index]]++
        }

        match := 0
        for k, v := range countSource {
            if t, ok := countTarget[k]; ok {
                match += min(v, t)
            }
        }
        total += len(indices) - match
    }

    return total
}

func min(a, b int) int {
    if a < b {
        return a
    }
    return b
}