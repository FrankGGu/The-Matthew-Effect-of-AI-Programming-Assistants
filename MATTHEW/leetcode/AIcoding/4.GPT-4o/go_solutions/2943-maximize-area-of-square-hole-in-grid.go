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
    for length := 1; length <= min(m, n); length++ {
        for i := length; i <= m; i++ {
            for j := length; j <= n; j++ {
                sum := prefix[i][j] - prefix[i-length][j] - prefix[i][j-length] + prefix[i-length][j-length]
                if sum <= threshold {
                    maxLen = length
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