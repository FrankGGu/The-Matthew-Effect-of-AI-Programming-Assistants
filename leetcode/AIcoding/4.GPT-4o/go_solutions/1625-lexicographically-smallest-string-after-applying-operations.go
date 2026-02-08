func smallestString(s string, operations [][]int) string {
    parent := make([]int, len(s))
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
        rootX := find(x)
        rootY := find(y)
        if rootX != rootY {
            parent[rootX] = rootY
        }
    }

    for _, op := range operations {
        union(op[0], op[1])
    }

    groups := make(map[int][]int)
    for i := range s {
        root := find(i)
        groups[root] = append(groups[root], i)
    }

    result := []byte(s)
    for _, indices := range groups {
        letters := make([]byte, len(indices))
        for i, idx := range indices {
            letters[i] = s[idx]
        }
        sort.Slice(letters, func(i, j int) bool {
            return letters[i] < letters[j]
        })
        sort.Ints(indices)
        for i, idx := range indices {
            result[idx] = letters[i]
        }
    }

    return string(result)
}