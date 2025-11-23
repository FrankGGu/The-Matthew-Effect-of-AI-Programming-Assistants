package main

func largestSubmatrix(matrix [][]int) int {
    m := len(matrix)
    n := len(matrix[0])
    for i := 0; i < m; i++ {
        for j := 0; j < n; j++ {
            if matrix[i][j] == 1 && i > 0 {
                matrix[i][j] += matrix[i-1][j]
            }
        }
    }
    res := 0
    for i := 0; i < m; i++ {
        sort.Ints(matrix[i])
        for j := n - 1; j >= 0; j-- {
            if matrix[i][j] == 0 {
                break
            }
            res = max(res, matrix[i][j]*(n-j))
        }
    }
    return res
}

func max(a, b int) int {
    if a > b {
        return a
    }
    return b
}