func matrixBlockSum(mat [][]int, K int) [][]int {
    m, n := len(mat), len(mat[0])
    result := make([][]int, m)
    for i := range result {
        result[i] = make([]int, n)
    }

    prefixSum := make([][]int, m+1)
    for i := range prefixSum {
        prefixSum[i] = make([]int, n+1)
    }

    for i := 1; i <= m; i++ {
        for j := 1; j <= n; j++ {
            prefixSum[i][j] = mat[i-1][j-1] + prefixSum[i-1][j] + prefixSum[i][j-1] - prefixSum[i-1][j-1]
        }
    }

    for i := 0; i < m; i++ {
        for j := 0; j < n; j++ {
            r1 := max(0, i-K)
            r2 := min(m-1, i+K)
            c1 := max(0, j-K)
            c2 := min(n-1, j+K)
            result[i][j] = prefixSum[r2+1][c2+1] - prefixSum[r1][c2+1] - prefixSum[r2+1][c1] + prefixSum[r1][c1]
        }
    }

    return result
}

func max(a, b int) int {
    if a > b {
        return a
    }
    return b
}

func min(a, b int) int {
    if a < b {
        return a
    }
    return b
}