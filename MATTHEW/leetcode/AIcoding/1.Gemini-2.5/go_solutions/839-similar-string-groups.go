package main

func numSimilarGroups(strs []string) int {
    n := len(strs)
    parent := make([]int, n)
    for i := 0; i < n; i++ {
        parent[i] = i
    }

    var find func(i int) int
    find = func(i int) int {
        if parent[i] == i {
            return i
        }
        parent[i] = find(parent[i])
        return parent[i]
    }

    union := func(i, j int) bool {
        rootI := find(i)
        rootJ := find(j)
        if rootI != rootJ {
            parent[rootI] = rootJ
            return true
        }
        return false
    }

    isSimilar := func(s1, s2 string) bool {
        diff := 0
        for i := 0; i < len(s1); i++ {
            if s1[i] != s2[i] {
                diff++
            }
        }
        return diff == 0 || diff == 2
    }

    numGroups := n
    for i := 0; i < n; i++ {
        for j := i + 1; j < n; j++ {
            if isSimilar(strs[i], strs[j]) {
                if union(i, j) {
                    numGroups--
                }
            }
        }
    }

    return numGroups
}