func modifyTheMatrix(matrix [][]int) [][]int {
    m := len(matrix)
    n := len(matrix[0])
    for i := 0; i < m; i++ {
        for j := 0; j < n; j++ {
            if matrix[i][j] == -1 {
                maxVal := -1
                for k := 0; k < n; k++ {
                    if matrix[i][k] > maxVal {
                        maxVal = matrix[i][k]
                    }
                }
                matrix[i][j] = 0
                for k := 0; k < n; k++ {
                    if matrix[i][k] > maxVal && matrix[i][k] != -1 {
                        maxVal = matrix[i][k]
                    }
                }
                if maxVal > 0 {
                    matrix[i][j] = maxVal
                }
            }
        }
    }
    return matrix
}