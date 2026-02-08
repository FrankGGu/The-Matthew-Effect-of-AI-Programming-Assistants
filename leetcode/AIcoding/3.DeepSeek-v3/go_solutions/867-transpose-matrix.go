func transpose(matrix [][]int) [][]int {
    if len(matrix) == 0 {
        return nil
    }
    rows, cols := len(matrix), len(matrix[0])
    transposed := make([][]int, cols)
    for i := range transposed {
        transposed[i] = make([]int, rows)
    }
    for i := 0; i < rows; i++ {
        for j := 0; j < cols; j++ {
            transposed[j][i] = matrix[i][j]
        }
    }
    return transposed
}