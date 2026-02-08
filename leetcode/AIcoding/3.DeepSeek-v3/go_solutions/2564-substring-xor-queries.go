func substringXorQueries(s string, queries [][]int) [][]int {
    n := len(s)
    m := make(map[int][]int)
    for l := 0; l < n; l++ {
        if s[l] == '0' {
            if _, ok := m[0]; !ok {
                m[0] = []int{l, l}
            }
            continue
        }
        num := 0
        for r := l; r < min(l+30, n); r++ {
            num = num<<1 | int(s[r]-'0')
            if _, ok := m[num]; !ok {
                m[num] = []int{l, r}
            }
        }
    }
    res := make([][]int, len(queries))
    for i, q := range queries {
        val := q[0] ^ q[1]
        if pos, ok := m[val]; ok {
            res[i] = pos
        } else {
            res[i] = []int{-1, -1}
        }
    }
    return res
}

func min(a, b int) int {
    if a < b {
        return a
    }
    return b
}