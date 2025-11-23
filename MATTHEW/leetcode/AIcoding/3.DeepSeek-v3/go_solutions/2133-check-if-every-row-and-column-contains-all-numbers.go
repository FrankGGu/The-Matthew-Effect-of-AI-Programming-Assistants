func checkValid(matrix [][]int) bool {
    n := len(matrix)

    for i := 0; i < n; i++ {
        rowSet := make(map[int]bool)
        colSet := make(map[int]bool)
        for j := 0; j < n; j++ {
            if matrix[i][j] < 1 || matrix[i][j] > n || rowSet[matrix[i][j]] {
                return false
            }
            rowSet[matrix[i][j]] = true

            if matrix[j][i] < 1 || matrix[j][i] > n || colSet[matrix[j][i]] {
                return false
            }
            colSet[matrix[j][i]] = true
        }
    }

    return true
}