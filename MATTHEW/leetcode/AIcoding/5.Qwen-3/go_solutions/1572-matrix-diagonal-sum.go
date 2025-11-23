package main

func diagonalSum(mat [][]int) int {
    n := len(mat)
    sum := 0
    for i := 0; i < n; i++ {
        sum += mat[i][i]
        if i != n-1-i {
            sum += mat[i][n-1-i]
        }
    }
    return sum
}