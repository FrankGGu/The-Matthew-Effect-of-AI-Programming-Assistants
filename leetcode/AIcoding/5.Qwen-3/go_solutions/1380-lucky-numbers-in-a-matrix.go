package main

func luckyNumbers (matrix [][]int) []int {
    rows := len(matrix)
    cols := len(matrix[0])
    minRow := make([]int, rows)
    maxCol := make([]int, cols)

    for i := 0; i < rows; i++ {
        minVal := matrix[i][0]
        for j := 1; j < cols; j++ {
            if matrix[i][j] < minVal {
                minVal = matrix[i][j]
            }
        }
        minRow[i] = minVal
    }

    for j := 0; j < cols; j++ {
        maxVal := matrix[0][j]
        for i := 1; i < rows; i++ {
            if matrix[i][j] > maxVal {
                maxVal = matrix[i][j]
            }
        }
        maxCol[j] = maxVal
    }

    result := make([]int, 0)
    for i := 0; i < rows; i++ {
        for j := 0; j < cols; j++ {
            if matrix[i][j] == minRow[i] && matrix[i][j] == maxCol[j] {
                result = append(result, matrix[i][j])
            }
        }
    }

    return result
}