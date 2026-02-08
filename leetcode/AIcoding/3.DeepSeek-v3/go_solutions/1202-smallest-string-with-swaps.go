func smallestStringWithSwaps(s string, pairs [][]int) string {
    n := len(s)
    parent := make([]int, n)
    for i := range parent {
        parent[i] = i
    }

    var find func(int) int
    find = func(u int) int {
        if parent[u] != u {
            parent[u] = find(parent[u])
        }
        return parent[u]
    }

    union := func(u, v int) {
        uRoot, vRoot := find(u), find(v)
        if uRoot != vRoot {
            parent[vRoot] = uRoot
        }
    }

    for _, pair := range pairs {
        union(pair[0], pair[1])
    }

    groups := make(map[int][]int)
    for i := 0; i < n; i++ {
        root := find(i)
        groups[root] = append(groups[root], i)
    }

    res := make([]byte, n)
    for _, indices := range groups {
        chars := make([]byte, len(indices))
        for i, idx := range indices {
            chars[i] = s[idx]
        }
        sort.Slice(chars, func(i, j int) bool {
            return chars[i] < chars[j]
        })
        for i, idx := range indices {
            res[idx] = chars[i]
        }
    }

    return string(res)
}