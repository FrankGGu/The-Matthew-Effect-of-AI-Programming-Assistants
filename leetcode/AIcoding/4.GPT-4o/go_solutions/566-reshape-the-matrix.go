func matrixReshape(mat [][]int, r int, c int) [][]int {
    if len(mat) == 0 || len(mat)*len(mat[0]) != r*c {
        return mat
    }

    reshaped := make([][]int, r)
    for i := range reshaped {
        reshaped[i] = make([]int, c)
    }

    for i := 0; i < len(mat); i++ {
        for j := 0; j < len(mat[0]); j++ {
            index := i*len(mat[0]) + j
            reshaped[index/c][index%c] = mat[i][j]
        }
    }

    return reshaped
}