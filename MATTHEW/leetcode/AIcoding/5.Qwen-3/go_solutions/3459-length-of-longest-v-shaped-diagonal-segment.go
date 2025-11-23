package main

func longestVShapeDiagonal(matrix [][]int) int {
    if len(matrix) == 0 || len(matrix[0]) == 0 {
        return 0
    }
    rows, cols := len(matrix), len(matrix[0])
    maxLen := 1

    for i := 0; i < rows; i++ {
        for j := 0; j < cols; j++ {
            current := 1
            x, y := i-1, j+1
            for x >= 0 && y < cols {
                current++
                x, y = x-1, y+1
            }
            x, y = i+1, j-1
            for x < rows && y >= 0 {
                current++
                x, y = x+1, y-1
            }
            if current > maxLen {
                maxLen = current
            }
        }
    }

    return maxLen
}