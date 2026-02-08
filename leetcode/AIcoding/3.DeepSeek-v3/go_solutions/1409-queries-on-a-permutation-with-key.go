func processQueries(queries []int, m int) []int {
    p := make([]int, m)
    for i := 0; i < m; i++ {
        p[i] = i + 1
    }
    res := make([]int, len(queries))
    for i, q := range queries {
        pos := 0
        for pos < m && p[pos] != q {
            pos++
        }
        res[i] = pos
        for j := pos; j > 0; j-- {
            p[j], p[j-1] = p[j-1], p[j]
        }
    }
    return res
}