package main

func modifiedMatrix(matrix [][]int) [][]int {
    m := len(matrix)
    n := len(matrix[0])
    for i := 0; i < m; i++ {
        for j := 0; j < n; j++ {
            maxVal := matrix[i][j]
            for k := 0; k < m; k++ {
                if matrix[k][j] > maxVal {
                    maxVal = matrix[k][j]
                }
            }
            matrix[i][j] = maxVal
        }
    }
    return matrix
}