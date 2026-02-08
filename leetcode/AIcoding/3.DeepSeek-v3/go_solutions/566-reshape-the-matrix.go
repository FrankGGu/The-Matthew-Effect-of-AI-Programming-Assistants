func matrixReshape(mat [][]int, r int, c int) [][]int {
    m, n := len(mat), len(mat[0])
    if m*n != r*c {
        return mat
    }
    reshaped := make([][]int, r)
    for i := range reshaped {
        reshaped[i] = make([]int, c)
    }
    for i := 0; i < m*n; i++ {
        reshaped[i/c][i%c] = mat[i/n][i%n]
    }
    return reshaped
}