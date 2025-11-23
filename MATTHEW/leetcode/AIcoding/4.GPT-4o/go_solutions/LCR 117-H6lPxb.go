func similarPairs(words []string) int {
    parent := make([]int, len(words))
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

    isSimilar := func(a, b string) bool {
        diff := 0
        for i := 0; i < len(a); i++ {
            if a[i] != b[i] {
                diff++
                if diff > 2 {
                    return false
                }
            }
        }
        return diff == 0 || diff == 2
    }

    for i := 0; i < len(words); i++ {
        for j := i + 1; j < len(words); j++ {
            if isSimilar(words[i], words[j]) {
                union(i, j)
            }
        }
    }

    rootCount := make(map[int]int)
    for i := 0; i < len(words); i++ {
        root := find(i)
        rootCount[root]++
    }

    return len(rootCount)
}