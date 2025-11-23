func numSimilarGroups(A []string) int {
    parent := make([]int, len(A))
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

    isSimilar := func(s1, s2 string) bool {
        diff := 0
        for i := 0; i < len(s1); i++ {
            if s1[i] != s2[i] {
                diff++
                if diff > 2 {
                    return false
                }
            }
        }
        return diff == 2 || diff == 0
    }

    for i := 0; i < len(A); i++ {
        for j := i + 1; j < len(A); j++ {
            if isSimilar(A[i], A[j]) {
                union(i, j)
            }
        }
    }

    groups := make(map[int]bool)
    for i := 0; i < len(A); i++ {
        groups[find(i)] = true
    }

    return len(groups)
}