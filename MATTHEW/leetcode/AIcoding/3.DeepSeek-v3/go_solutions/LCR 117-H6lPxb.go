func numSimilarGroups(strs []string) int {
    n := len(strs)
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
        parent[find(x)] = find(y)
    }

    for i := 0; i < n; i++ {
        for j := i + 1; j < n; j++ {
            if isSimilar(strs[i], strs[j]) {
                union(i, j)
            }
        }
    }

    groups := make(map[int]bool)
    for i := 0; i < n; i++ {
        groups[find(i)] = true
    }
    return len(groups)
}

func isSimilar(a, b string) bool {
    diff := 0
    for i := 0; i < len(a); i++ {
        if a[i] != b[i] {
            diff++
            if diff > 2 {
                return false
            }
        }
    }
    return true
}