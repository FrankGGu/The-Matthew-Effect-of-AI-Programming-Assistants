package main

func numSimilarGroups(strs []string) int {
    n := len(strs)
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

    var union func(x, y int)
    union = func(x, y int) {
        rootX := find(x)
        rootY := find(y)
        if rootX != rootY {
            parent[rootY] = rootX
        }
    }

    for i := 0; i < n; i++ {
        for j := i + 1; j < n; j++ {
            if areSimilar(strs[i], strs[j]) {
                union(i, j)
            }
        }
    }

    roots := make(map[int]bool)
    for i := 0; i < n; i++ {
        roots[find(i)] = true
    }

    return len(roots)
}

func areSimilar(s1, s2 string) bool {
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