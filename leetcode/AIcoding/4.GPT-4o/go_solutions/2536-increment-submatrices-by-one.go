func incrementSubmatrices(mat [][]int, row1 int, col1 int, row2 int, col2 int) [][]int {
    for i := row1; i <= row2; i++ {
        for j := col1; j <= col2; j++ {
            mat[i][j]++
        }
    }
    return mat
}