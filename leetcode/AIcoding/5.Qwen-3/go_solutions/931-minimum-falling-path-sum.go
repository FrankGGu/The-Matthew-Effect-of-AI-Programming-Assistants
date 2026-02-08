package main

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
    minSum := matrix[0][0]
    for _, val := range matrix[0] {
        if val < minSum {
            minSum = val
        }
    }
    return minSum
}

func min(a, b int) int {
    if a < b {
        return a
    }
    return b
}