func luckyNumbers(matrix [][]int) []int {
    minRows := make([]int, len(matrix))
    maxCols := make([]int, len(matrix[0]))

    for i := range minRows {
        minRows[i] = math.MaxInt32
    }

    for i := 0; i < len(matrix); i++ {
        for j := 0; j < len(matrix[0]); j++ {
            if matrix[i][j] < minRows[i] {
                minRows[i] = matrix[i][j]
            }
            if matrix[i][j] > maxCols[j] {
                maxCols[j] = matrix[i][j]
            }
        }
    }

    var result []int
    for i := 0; i < len(matrix); i++ {
        for j := 0; j < len(matrix[0]); j++ {
            if matrix[i][j] == minRows[i] && matrix[i][j] == maxCols[j] {
                result = append(result, matrix[i][j])
            }
        }
    }

    return result
}