func luckyNumbers (matrix [][]int) []int {
    m := len(matrix)
    n := len(matrix[0])

    rowMins := make([]int, m)
    for i := 0; i < m; i++ {
        minVal := matrix[i][0]
        for j := 1; j < n; j++ {
            if matrix[i][j] < minVal {
                minVal = matrix[i][j]
            }
        }
        rowMins[i] = minVal
    }

    colMaxs := make([]int, n)
    for j := 0; j < n; j++ {
        maxVal := matrix[0][j]
        for i := 1; i < m; i++ {
            if matrix[i][j] > maxVal {
                maxVal = matrix[i][j]
            }
        }
        colMaxs[j] = maxVal
    }

    var luckyNumbers []int
    for i := 0; i < m; i++ {
        for j := 0; j < n; j++ {
            if matrix[i][j] == rowMins[i] && matrix[i][j] == colMaxs[j] {
                luckyNumbers = append(luckyNumbers, matrix[i][j])
            }
        }
    }

    return luckyNumbers
}