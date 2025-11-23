package main

func smallestStringWithSwaps(s string, pairs [][]int) string {
    parent := make([]int, len(s))

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

    for _, pair := range pairs {
        x, y := pair[0], pair[1]
        px, py := find(x), find(y)
        if px != py {
            parent[px] = py
        }
    }

    groups := make(map[int][]int)
    for i := range s {
        root := find(i)
        groups[root] = append(groups[root], i)
    }

    res := []byte(s)
    for _, indices := range groups {
        chars := make([]byte, len(indices))
        for i, idx := range indices {
            chars[i] = res[idx]
        }
        sort.Slice(chars, func(i, j int) bool { return chars[i] < chars[j] })
        for i, idx := range indices {
            res[idx] = chars[i]
        }
    }

    return string(res)
}