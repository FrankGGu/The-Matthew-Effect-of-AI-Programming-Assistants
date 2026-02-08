func maxSideLength(mat [][]int, threshold int) int {
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

    maxLen := 0
    for i := 1; i <= m; i++ {
        for j := 1; j <= n; j++ {
            for k := maxLen + 1; k <= min(m, n); k++ {
                if i < k || j < k {
                    break
                }
                sum := prefix[i][j] - prefix[i-k][j] - prefix[i][j-k] + prefix[i-k][j-k]
                if sum <= threshold {
                    maxLen = k
                } else {
                    break
                }
            }
        }
    }
    return maxLen
}

func min(a, b int) int {
    if a < b {
        return a
    }
    return b
}