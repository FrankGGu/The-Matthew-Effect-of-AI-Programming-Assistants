package main

func diagonalSort(matrix [][]int) [][]int {
    m := len(matrix)
    n := len(matrix[0])

    for i := 0; i < m; i++ {
        for j := 0; j < n; j++ {
            temp := matrix[i][j]
            x, y := i, j
            for x+1 < m && y+1 < n {
                x++
                y++
                if matrix[x][y] < temp {
                    temp = matrix[x][y]
                }
            }
            x, y = i, j
            for x+1 < m && y+1 < n {
                x++
                y++
                matrix[x][y], temp = temp, matrix[x][y]
            }
        }
    }

    return matrix
}