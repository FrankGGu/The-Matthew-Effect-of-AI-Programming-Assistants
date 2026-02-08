func rangeAddQueries(n int, queries [][]int) [][]int {
    mat := make([][]int, n)
    for i := range mat {
        mat[i] = make([]int, n)
    }

    for _, q := range queries {
        r1, c1, r2, c2 := q[0], q[1], q[2], q[3]
        for i := r1; i <= r2; i++ {
            mat[i][c1]++
            if c2+1 < n {
                mat[i][c2+1]--
            }
        }
    }

    for i := 0; i < n; i++ {
        for j := 1; j < n; j++ {
            mat[i][j] += mat[i][j-1]
        }
    }

    return mat
}