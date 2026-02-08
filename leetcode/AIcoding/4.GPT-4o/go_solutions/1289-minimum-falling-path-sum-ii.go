func minFallingPathSum(matrix [][]int) int {
    n := len(matrix)
    if n == 0 {
        return 0
    }

    for i := n - 2; i >= 0; i-- {
        for j := 0; j < n; j++ {
            minSum := math.MaxInt32
            for k := 0; k < n; k++ {
                if k != j {
                    minSum = min(minSum, matrix[i+1][k])
                }
            }
            matrix[i][j] += minSum
        }
    }

    minResult := math.MaxInt32
    for j := 0; j < n; j++ {
        minResult = min(minResult, matrix[0][j])
    }

    return minResult
}

func min(a, b int) int {
    if a < b {
        return a
    }
    return b
}