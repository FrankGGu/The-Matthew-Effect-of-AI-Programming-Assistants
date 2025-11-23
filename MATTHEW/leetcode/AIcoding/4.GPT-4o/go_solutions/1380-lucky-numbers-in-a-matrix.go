func luckyNumbers (matrix [][]int) []int {
    if len(matrix) == 0 || len(matrix[0]) == 0 {
        return []int{}
    }

    m, n := len(matrix), len(matrix[0])
    rowMin := make([]int, m)
    colMax := make([]int, n)

    for i := 0; i < m; i++ {
        rowMin[i] = matrix[i][0]
        for j := 1; j < n; j++ {
            if matrix[i][j] < rowMin[i] {
                rowMin[i] = matrix[i][j]
            }
        }
    }

    for j := 0; j < n; j++ {
        colMax[j] = matrix[0][j]
        for i := 1; i < m; i++ {
            if matrix[i][j] > colMax[j] {
                colMax[j] = matrix[i][j]
            }
        }
    }

    luckyNumbers := []int{}
    for i := 0; i < m; i++ {
        for j := 0; j < n; j++ {
            if matrix[i][j] == rowMin[i] && matrix[i][j] == colMax[j] {
                luckyNumbers = append(luckyNumbers, matrix[i][j])
            }
        }
    }

    return luckyNumbers
}