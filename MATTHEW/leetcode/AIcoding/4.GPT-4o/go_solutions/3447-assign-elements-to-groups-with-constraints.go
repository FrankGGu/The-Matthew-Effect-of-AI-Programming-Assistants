func canAssign(n int, m int, groups [][]int) bool {
    parent := make([]int, n)
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
        parent[find(x)] = find(y)
    }

    for _, group := range groups {
        if len(group) == 0 {
            continue
        }
        root := group[0]
        for _, member := range group[1:] {
            union(root, member)
        }
    }

    count := make(map[int]int)
    for i := 0; i < n; i++ {
        count[find(i)]++
    }

    return len(count) <= m
}

func canAssignElementsToGroups(n int, m int, groups [][]int) bool {
    return canAssign(n, m, groups)
}