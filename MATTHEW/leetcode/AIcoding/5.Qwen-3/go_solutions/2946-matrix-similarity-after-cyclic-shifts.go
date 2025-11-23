package main

func matrixSimilarityAfterCyclicShifts(matrix [][]int) bool {
    rows := len(matrix)
    cols := len(matrix[0])

    for i := 0; i < rows; i++ {
        for j := 0; j < cols; j++ {
            if matrix[i][j] != matrix[(i+1)%rows][j] {
                return false
            }
        }
    }

    return true
}