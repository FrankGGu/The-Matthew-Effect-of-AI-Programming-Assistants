package main

func isToeplitzMatrix(matrix [][]int) bool {
    rows := len(matrix)
    cols := len(matrix[0])
    for i := 0; i < rows; i++ {
        for j := 0; j < cols; j++ {
            if i > 0 && j > 0 && matrix[i][j] != matrix[i-1][j-1] {
                return false
            }
        }
    }
    return true
}