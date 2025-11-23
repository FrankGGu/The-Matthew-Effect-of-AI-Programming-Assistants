func matrixSumQueries(n int, queries [][]int) int64 {
    row := make(map[int]bool)
    col := make(map[int]bool)
    var res int64
    r, c := n, n
    for i := len(queries) - 1; i >= 0; i-- {
        q := queries[i]
        t, idx, val := q[0], q[1], q[2]
        if t == 0 {
            if !row[idx] {
                res += int64(val * c)
                row[idx] = true
                r--
            }
        } else {
            if !col[idx] {
                res += int64(val * r)
                col[idx] = true
                c--
            }
        }
    }
    return res
}