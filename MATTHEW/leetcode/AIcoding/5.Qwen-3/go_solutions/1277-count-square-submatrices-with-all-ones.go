package main

func countSquares(matrix [][]int) int {
    m := len(matrix)
    n := len(matrix[0])
    res := 0
    for i := 0; i < m; i++ {
        for j := 0; j < n; j++ {
            if matrix[i][j] == 1 {
                if i == 0 || j == 0 {
                    res++
                } else {
                    minVal := min(matrix[i-1][j-1], matrix[i-1][j], matrix[i][j-1])
                    matrix[i][j] = minVal + 1
                    res += matrix[i][j]
                }
            }
        }
    }
    return res
}

func min(a, b, c int) int {
    if a <= b && a <= c {
        return a
    } else if b <= a && b <= c {
        return b
    } else {
        return c
    }
}