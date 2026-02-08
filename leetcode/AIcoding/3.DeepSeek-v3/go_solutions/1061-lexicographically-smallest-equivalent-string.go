func smallestEquivalentString(s1 string, s2 string, baseStr string) string {
    parent := make([]int, 26)
    for i := range parent {
        parent[i] = i
    }

    var find func(int) int
    find = func(u int) int {
        if parent[u] != u {
            parent[u] = find(parent[u])
        }
        return parent[u]
    }

    union := func(u, v int) {
        pu, pv := find(u), find(v)
        if pu < pv {
            parent[pv] = pu
        } else {
            parent[pu] = pv
        }
    }

    for i := 0; i < len(s1); i++ {
        u := int(s1[i] - 'a')
        v := int(s2[i] - 'a')
        union(u, v)
    }

    res := []byte{}
    for _, c := range baseStr {
        p := find(int(c - 'a'))
        res = append(res, byte(p+'a'))
    }
    return string(res)
}