func modifiedMatrix(matrix [][]int) [][]int {
    m := len(matrix)
    n := len(matrix[0])
    maxCols := make([]int, n)

    for j := 0; j < n; j++ {
        maxVal := -1
        for i := 0; i < m; i++ {
            if matrix[i][j] > maxVal {
                maxVal = matrix[i][j]
            }
        }
        maxCols[j] = maxVal
    }

    for i := 0; i < m; i++ {
        for j := 0; j < n; j++ {
            if matrix[i][j] == -1 {
                matrix[i][j] = maxCols[j]
            }
        }
    }

    return matrix
}