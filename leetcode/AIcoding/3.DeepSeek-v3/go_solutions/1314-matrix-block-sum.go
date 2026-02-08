func matrixBlockSum(mat [][]int, k int) [][]int {
    m, n := len(mat), len(mat[0])
    prefix := make([][]int, m+1)
    for i := range prefix {
        prefix[i] = make([]int, n+1)
    }

    for i := 1; i <= m; i++ {
        for j := 1; j <= n; j++ {
            prefix[i][j] = mat[i-1][j-1] + prefix[i-1][j] + prefix[i][j-1] - prefix[i-1][j-1]
        }
    }

    res := make([][]int, m)
    for i := range res {
        res[i] = make([]int, n)
    }

    for i := 0; i < m; i++ {
        for j := 0; j < n; j++ {
            r1 := max(0, i - k)
            c1 := max(0, j - k)
            r2 := min(m - 1, i + k)
            c2 := min(n - 1, j + k)
            res[i][j] = prefix[r2+1][c2+1] - prefix[r1][c2+1] - prefix[r2+1][c1] + prefix[r1][c1]
        }
    }

    return res
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