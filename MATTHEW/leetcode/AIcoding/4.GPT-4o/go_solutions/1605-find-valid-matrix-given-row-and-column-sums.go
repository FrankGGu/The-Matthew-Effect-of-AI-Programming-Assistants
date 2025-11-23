func restoreMatrix(rowSum []int, colSum []int) [][]int {
    m := len(rowSum)
    n := len(colSum)
    result := make([][]int, m)
    for i := range result {
        result[i] = make([]int, n)
    }

    for i := 0; i < m; i++ {
        for j := 0; j < n; j++ {
            result[i][j] = min(rowSum[i], colSum[j])
            rowSum[i] -= result[i][j]
            colSum[j] -= result[i][j]
        }
    }
    return result
}

func min(a, b int) int {
    if a < b {
        return a
    }
    return b
}