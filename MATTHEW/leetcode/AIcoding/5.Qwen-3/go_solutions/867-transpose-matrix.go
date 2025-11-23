package main

func transpose(matrix [][]int) [][]int {
    rows := len(matrix)
    cols := len(matrix[0])
    result := make([][]int, cols)
    for i := 0; i < cols; i++ {
        result[i] = make([]int, rows)
        for j := 0; j < rows; j++ {
            result[i][j] = matrix[j][i]
        }
    }
    return result
}