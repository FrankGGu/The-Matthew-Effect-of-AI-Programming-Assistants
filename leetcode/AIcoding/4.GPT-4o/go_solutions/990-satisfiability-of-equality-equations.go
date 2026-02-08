func equationsPossible(equations []string) bool {
    parent := make([]int, 26)
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

    for _, eq := range equations {
        if eq[1] == '=' {
            union(int(eq[0]-'a'), int(eq[3]-'a'))
        }
    }

    for _, eq := range equations {
        if eq[1] == '!' {
            if find(int(eq[0]-'a')) == find(int(eq[3]-'a')) {
                return false
            }
        }
    }

    return true
}