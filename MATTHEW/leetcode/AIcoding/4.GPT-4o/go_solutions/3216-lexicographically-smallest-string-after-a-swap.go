func lexSmallestString(s string, swapPairs [][]int) string {
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
            parent[rootY] = rootX
        }
    }

    for _, pair := range swapPairs {
        union(pair[0], pair[1])
    }

    groups := make(map[int][]rune)
    for i := range s {
        root := find(i)
        groups[root] = append(groups[root], rune(s[i]))
    }

    for _, group := range groups {
        sort.Slice(group, func(i, j int) bool {
            return group[i] < group[j]
        })
    }

    result := make([]rune, len(s))
    for i := range s {
        root := find(i)
        result[i] = groups[root][0]
        groups[root] = groups[root][1:]
    }

    return string(result)
}