func areSimilar(mat [][]int, k int) bool {
    m := len(mat)
    if m == 0 {
        return true
    }
    n := len(mat[0])
    if n == 0 {
        return true
    }
    k %= n
    if k == 0 {
        return true
    }
    for i := 0; i < m; i++ {
        row := make([]int, n)
        copy(row, mat[i])
        if i%2 == 0 {
            for j := 0; j < n; j++ {
                mat[i][(j+k)%n] = row[j]
            }
        } else {
            for j := 0; j < n; j++ {
                mat[i][(j-k+n)%n] = row[j]
            }
        }
    }
    for i := 0; i < m; i++ {
        for j := 0; j < n; j++ {
            if mat[i][j] != mat[i][(j+k)%n] {
                return false
            }
        }
    }
    return true
}