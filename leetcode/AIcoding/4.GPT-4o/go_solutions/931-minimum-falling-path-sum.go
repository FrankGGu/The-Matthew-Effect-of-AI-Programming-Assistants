func minFallingPathSum(matrix [][]int) int {
    n := len(matrix)
    for i := 1; i < n; i++ {
        for j := 0; j < n; j++ {
            minVal := matrix[i-1][j]
            if j > 0 {
                minVal = min(minVal, matrix[i-1][j-1])
            }
            if j < n-1 {
                minVal = min(minVal, matrix[i-1][j+1])
            }
            matrix[i][j] += minVal
        }
    }
    minSum := matrix[n-1][0]
    for j := 1; j < n; j++ {
        minSum = min(minSum, matrix[n-1][j])
    }
    return minSum
}

func min(a, b int) int {
    if a < b {
        return a
    }
    return b
}