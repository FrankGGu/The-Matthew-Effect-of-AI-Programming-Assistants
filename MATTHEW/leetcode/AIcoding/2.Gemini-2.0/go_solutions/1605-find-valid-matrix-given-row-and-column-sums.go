func restoreMatrix(rowSum []int, colSum []int) [][]int {
    m, n := len(rowSum), len(colSum)
    matrix := make([][]int, m)
    for i := range matrix {
        matrix[i] = make([]int, n)
    }

    for i := 0; i < m; i++ {
        for j := 0; j < n; j++ {
            val := min(rowSum[i], colSum[j])
            matrix[i][j] = val
            rowSum[i] -= val
            colSum[j] -= val
        }
    }

    return matrix
}

func min(a, b int) int {
    if a < b {
        return a
    }
    return b
}