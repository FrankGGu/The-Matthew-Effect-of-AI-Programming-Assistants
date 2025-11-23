func smallestEquivalentString(s1 string, s2 string, baseStr string) string {
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

    var union func(int, int)
    union = func(x, y int) {
        rootX := find(x)
        rootY := find(y)
        if rootX < rootY {
            parent[rootY] = rootX
        } else {
            parent[rootX] = rootY
        }
    }

    for i := 0; i < len(s1); i++ {
        union(int(s1[i]-'a'), int(s2[i]-'a'))
    }

    result := make([]byte, len(baseStr))
    for i := 0; i < len(baseStr); i++ {
        result[i] = byte(find(int(baseStr[i]-'a')) + 'a')
    }

    return string(result)
}