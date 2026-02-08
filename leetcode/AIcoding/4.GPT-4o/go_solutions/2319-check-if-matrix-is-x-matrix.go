func checkXMatrix(matrix [][]int) bool {
    n := len(matrix)
    for i := 0; i < n; i++ {
        for j := 0; j < n; j++ {
            if (i == j || i+j == n-1) && matrix[i][j] == 0 {
                return false
            }
            if (i != j && i+j != n-1) && matrix[i][j] != 0 {
                return false
            }
        }
    }
    return true
}