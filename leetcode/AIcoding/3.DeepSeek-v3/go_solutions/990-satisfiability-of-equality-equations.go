func equationsPossible(equations []string) bool {
    parent := make([]int, 26)
    for i := 0; i < 26; i++ {
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

    for _, eq := range equations {
        if eq[1] == '=' {
            x := int(eq[0] - 'a')
            y := int(eq[3] - 'a')
            union(x, y)
        }
    }

    for _, eq := range equations {
        if eq[1] == '!' {
            x := int(eq[0] - 'a')
            y := int(eq[3] - 'a')
            if find(x) == find(y) {
                return false
            }
        }
    }

    return true
}