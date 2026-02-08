package main

func maximumSum(matrix [][]int) int {
    rows := len(matrix)
    cols := len(matrix[0])
    maxSum := -1 << 31

    for i := 0; i <= rows-3; i++ {
        for j := 0; j <= cols-3; j++ {
            sum := matrix[i][j] + matrix[i][j+1] + matrix[i][j+2] +
                  matrix[i+1][j+1] +
                  matrix[i+2][j] + matrix[i+2][j+1] + matrix[i+2][j+2]
            if sum > maxSum {
                maxSum = sum
            }
        }
    }

    return maxSum
}