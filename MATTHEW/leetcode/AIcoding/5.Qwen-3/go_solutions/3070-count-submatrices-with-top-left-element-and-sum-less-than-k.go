package main

func countSubmatrices(matrix [][]int, k int) int {
    m, n := len(matrix), len(matrix[0])
    for i := 0; i < m; i++ {
        for j := 1; j < n; j++ {
            matrix[i][j] += matrix[i][j-1]
        }
    }
    count := 0
    for j := 0; j < n; j++ {
        for i := 0; i < m; i++ {
            sum := 0
            for k2 := i; k2 < m; k2++ {
                sum += matrix[k2][j]
                if sum < k {
                    count++
                } else {
                    break
                }
            }
        }
    }
    return count
}