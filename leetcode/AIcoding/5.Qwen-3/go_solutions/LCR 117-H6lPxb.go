package main

func numSimilarGroups(strs []string) int {
    parent := make(map[string]string)

    find := func(s string) string {
        if parent[s] != s {
            parent[s] = find(parent[s])
        }
        return parent[s]
    }

    union := func(s1, s2 string) {
        root1 := find(s1)
        root2 := find(s2)
        if root1 != root2 {
            parent[root1] = root2
        }
    }

    for _, s := range strs {
        parent[s] = s
    }

    for i := 0; i < len(strs); i++ {
        for j := i + 1; j < len(strs); j++ {
            if areSimilar(strs[i], strs[j]) {
                union(strs[i], strs[j])
            }
        }
    }

    result := make(map[string]bool)
    for _, s := range strs {
        result[find(s)] = true
    }

    return len(result)
}

func areSimilar(s1, s2 string) bool {
    diff := 0
    for i := 0; i < len(s1) && diff <= 2; i++ {
        if s1[i] != s2[i] {
            diff++
        }
    }
    return diff == 2
}