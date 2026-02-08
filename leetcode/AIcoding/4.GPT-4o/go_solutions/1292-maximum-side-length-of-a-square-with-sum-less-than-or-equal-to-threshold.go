func maxSideLength(mat [][]int, threshold int) int {
    m, n := len(mat), len(mat[0])
    prefixSum := make([][]int, m+1)
    for i := range prefixSum {
        prefixSum[i] = make([]int, n+1)
    }

    for i := 1; i <= m; i++ {
        for j := 1; j <= n; j++ {
            prefixSum[i][j] = mat[i-1][j-1] + prefixSum[i-1][j] + prefixSum[i][j-1] - prefixSum[i-1][j-1]
        }
    }

    maxSide := 0

    for side := 1; side <= min(m, n); side++ {
        for i := side; i <= m; i++ {
            for j := side; j <= n; j++ {
                sum := prefixSum[i][j] - prefixSum[i-side][j] - prefixSum[i][j-side] + prefixSum[i-side][j-side]
                if sum <= threshold {
                    maxSide = side
                }
            }
        }
    }

    return maxSide
}

func min(a, b int) int {
    if a < b {
        return a
    }
    return b
}