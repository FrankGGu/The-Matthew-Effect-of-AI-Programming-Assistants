func modifyMatrix(matrix [][]int) [][]int {
    rows, cols := len(matrix), len(matrix[0])
    zeroRows, zeroCols := make([]bool, rows), make([]bool, cols)

    for i := 0; i < rows; i++ {
        for j := 0; j < cols; j++ {
            if matrix[i][j] == 0 {
                zeroRows[i] = true
                zeroCols[j] = true
            }
        }
    }

    for i := 0; i < rows; i++ {
        for j := 0; j < cols; j++ {
            if zeroRows[i] || zeroCols[j] {
                matrix[i][j] = 0
            }
        }
    }

    return matrix
}