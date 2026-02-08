func modifyColumns(matrix [][]int) [][]int {
    if len(matrix) == 0 {
        return matrix
    }

    rows, cols := len(matrix), len(matrix[0])
    for j := 0; j < cols; j++ {
        maxVal := matrix[0][j]
        for i := 1; i < rows; i++ {
            if matrix[i][j] > maxVal {
                maxVal = matrix[i][j]
            }
        }
        for i := 0; i < rows; i++ {
            matrix[i][j] = maxVal
        }
    }
    return matrix
}