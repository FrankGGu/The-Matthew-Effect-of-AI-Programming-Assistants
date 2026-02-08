package main

func minFallingPathSum(matrix [][]int) int {
    n := len(matrix)
    for i := 1; i < n; i++ {
        for j := 0; j < n; j++ {
            minVal := 1<<31 - 1
            for k := 0; k < n; k++ {
                if k != j {
                    minVal = min(minVal, matrix[i-1][k])
                }
            }
            matrix[i][j] += minVal
        }
    }
    return min(matrix[n-1]...)
}

func min(a, b int) int {
    if a < b {
        return a
    }
    return b
}