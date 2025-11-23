func isToeplitzMatrix(matrix [][]int) bool {
    m := len(matrix)
    n := len(matrix[0])

    for r := 1; r < m; r++ {
        for c := 1; c < n; c++ {
            if matrix[r][c] != matrix[r-1][c-1] {
                return false
            }
        }
    }

    return true
}